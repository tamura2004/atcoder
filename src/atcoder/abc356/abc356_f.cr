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
  getter st : Orderedset(Tuple(Int64, Int64, Set(Int64)))
  getter k : Int64

  def initialize(@k)
    @st = Orderedset(Tuple(Int64, Int64)).new
    st << ({Int64::MIN, Int64::MIN, Set(Int64).new})
    st << ({Int64::MAX, Int64::MAX, Set(Int64).new})
    @cnt = Hash(Int64, Int64).new(0_i64)
  end

  def covered_by(x : Int64)
    r = st.lower({x + 1, x + 1, Set(Int64).new}, eq: false).not_nil! # xが含まれる区間
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
    lo = st.lower({x, x, Set.new([x])}, eq: true).not_nil! # 番兵がいるので安全
    hi = st.upper({x, x, Set.new([x])}, eq: true).not_nil! # 番兵がいるので安全
    if lo[1] == x - k && hi[0] == x + k
      st.delete(lo)
      st.delete(hi)
      st << ({lo[0], hi[1], lo[2] + hi[2] + Set.new([x])})
    elsif lo[1] == x - k
      st.delete(lo)
      st << ({lo[0], x, lo[2] + Set.new([x])})
    elsif hi[0] == x + k
      st.delete(hi)
      st << ({x, hi[1], hi[2] + Set.new([x])})
    else
      st << ({x, x, Set.new([x])})
    end
  end

  def <<(x : Int64)
    add(x)
  end

  def delete(x : Int64)
    if r = covered_by(x)
      st.delete(r)
      st << ({r[0], x - 1, r[2].select(&.< x)}) if r[0] < x
      st << ({x + 1, r[1], r[2].select(&.> x)}) if x < r[1]
    end
  end

  def >>(x : Int64)
    delete(x)
  end
end

q, k = gets.to_s.split.map(&.to_i64)
ns = NekoSet.new(k)
q.times do
  t, x = gets.to_s.split.map(&.to_i64)
  if t == 1
    ns << x
  else
    ns >> x
  end
  puts ns.st[0][0] + k
end 