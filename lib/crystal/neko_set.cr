require "crystal/orderedset"

# 区間をセットで管理するデータ構造
# 要素の追加、削除とmexを対数時間で求めることができる
#
# ```
# ns = NekoSet.new
# ns << 0
# ns << 1
# ns << 2
# ns << 4
# ns.mex.should eq 3
# ns << 3
# ns.mex.should eq 5
# ```
class NekoSet
  getter st : Orderedset(Tuple(Int64, Int64))
  getter cnt : Hash(Int64, Int64)

  def initialize
    @st = Orderedset(Tuple(Int64, Int64)).new
    st << ({Int64::MIN, Int64::MIN})
    st << ({Int64::MAX, Int64::MAX})
    @cnt = Hash(Int64, Int64).new(0_i64)
  end

  def inc(x : Int64)
    add(x) if cnt[x].zero?
    cnt[x] += 1
  end

  def dec(x : Int64)
    cnt[x] -= 1
    delete(x) if cnt[x].zero?
  end

  def covered_by(x : Int64)
    r = st.lower({x + 1, x + 1}, eq: false).not_nil! # xが含まれる区間
    r[0] <= x <= r[1] ? r : nil
  end

  def covered?(x : Int64)
    !covered_by(x).nil?
  end

  def includes?(x : Int64)
    covered?(x)
  end

  def add(x : Int64)
    return if includes?(x)
    lo = st.lower({x, x}, eq: true).not_nil! # 番兵がいるので安全
    hi = st.upper({x, x}, eq: true).not_nil! # 番兵がいるので安全
    if lo[1] == x - 1 && hi[0] == x + 1
      st.delete(lo)
      st.delete(hi)
      st << ({lo[0], hi[1]})
    elsif lo[1] == x - 1
      st.delete(lo)
      st << ({lo[0], x})
    elsif hi[0] == x + 1
      st.delete(hi)
      st << ({x, hi[1]})
    else
      st << ({x, x})
    end
  end

  def <<(x : Int64)
    add(x)
  end

  def delete(x : Int64)
    if r = covered_by(x)
      st.delete(r)
      st << ({r[0], x - 1}) if r[0] < x
      st << ({x + 1, r[1]}) if x < r[1]
    end
  end

  def >>(x : Int64)
    delete(x)
  end

  def mex(x : Int64 = 0_i64)
    if r = covered_by(x)
      r[1] + 1
    else
      x
    end
  end

  def to_a
    st.to_a[1..-2]
  end
end

class Array(T)
  def to_neko_set
    NekoSet.new.tap do |ns|
      each do |x|
        ns << x
      end
    end
  end
end