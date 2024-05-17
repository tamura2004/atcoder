require "crystal/segment_tree_beats"

# 範囲chmin,範囲sum
# 最大値と第2最大値、最大値の個数、合計、失敗フラグを持つ
record X, fst : Int64, snd : Int64, cnt : Int64, sum : Int64, fail : Bool do
  # 加法の単位元
  def self.zero
    new Int64::MIN, Int64::MIN, 0_i64, 0_i64, false
  end

  def initialize(@fst)
    @snd = Int64::MIN
    @cnt = 1_i64
    @sum = @fst
    @fail = false
  end

  def +(other : self) : self
    if fst == other.fst
      # 最大値が同じ区間のマージ
      #
      # fst ----   fst ----   fst ----
      #          +          = 
      # snd ----              snd ----
      #            snd ----
      #
      X.new fst, Math.max(snd, other.snd), cnt + other.cnt, sum + other.sum, false
    elsif fst > other.fst
      # 自身の最大値が他の最大値より大きい場合、自身の最大値を維持
      #
      # fst ----              fst ----
      #          + fst ---- = snd ----
      # snd ----   snd ----
      #
      X.new fst, Math.max(snd, other.fst), cnt, sum + other.sum, false
    else
      # 自身の最大値が他の最大値より小さい場合、最大値を更新
      #
      #            fst ----   fst ----
      # fst ---- +          = snd ----
      # snd ----   snd ----
      #
      X.new other.fst, Math.max(fst, other.snd), other.cnt, sum + other.sum, false
    end
  end

  def *(other : A) : self
    if fst <= other.val
      # 最大値の更新の際、現在の最大値を超えれば何もしない
      #
      # x   ----
      # fst ----
      # snd ----
      self
    elsif snd < other.val
      # 最大値の更新の際、第２最大値を超え、かつ最大値未満であれば、最大値の個数を利用して合計の更新を行う
      #
      # fst ----
      # x   ---- -> sum -= (fst - x) * cnt
      # snd ----
      X.new other.val, snd, cnt, sum - cnt * (fst - other.val), false
    else
      # 第２最大値以下であれば、更新できないので失敗フラグを立てる
      # このノードに対する遅延評価を行うときに、失敗フラグが立っていれば子に伝搬する
      #
      # fst ----
      # snd ---- -> fail
      # x   ----
      X.new fst, snd, cnt, sum, true
    end
  end
end

record A, val : Int64 do
  # 加法の単位元
  def self.zero
    new Int64::MAX
  end

  def +(other : self) : self
    if val <= other.val
      self
    else
      other
    end
  end
end

class Array(T)
  def to_range_chmin_range_sum
    SegmentTreeBeats(X, A).new(map(&.to_i64))
  end
end
