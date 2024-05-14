require "crystal/segment_tree_beats"

# 区間chmin, 区間sum
#
# ```
# values = [3, 1, 4, 1, 5]
# st = values.to_range_chmin_range_sum
# st[0..].should eq 14
# st[1..3] = 2 # => [3, 1, 2, 1, 5]
# st[0..].should eq 12
# st[0..] = 3 # => [3, 1, 2, 1, 3]
# st[2..4].should eq 6
# ```
class RangeChminRangeSum(T)
  class Node(T)
    getter fst : T     # 区間の最大値
    getter cnt : Int32 # 区間の最大値の要素数
    getter snd : T     # 区間で2番目に大きい値
    getter sum : T     # 区間の合計
    getter lazy : T?   # 遅延評価用の値

    def self.zero
      new(T.zero)
    end

    def initialize(@fst : T)
      @cnt = 1
      @snd = T::MIN
      @sum = @fst
      @lazy = nil.as(T?)
    end

    # 子の情報を使って自分の情報を更新する
    def update(l : self, r : self)
      if l.fst == r.fst
        @fst = l.fst
        @cnt = l.cnt + r.cnt
        @snd = Math.max l.snd, r.snd
      elsif l.fst < r.fst
        @fst = r.fst
        @cnt = r.cnt
        @snd = Math.max r.snd, l.fst
      else
        @fst = l.fst
        @cnt = l.cnt
        @snd = Math.max l.snd, r.fst
      end
      @sum = l.sum + r.sum
    end

    # 子に遅延評価用の値を適用する
    def push(l : self, r : self)
      if x = @lazy
        l.add(x)
        r.add(x)
        @lazy = nil.as(T?)
      end
    end

    def add(b : T)
      if a = lazy
        @lazy = Math.min a, b
      else
        @lazy = b
      end
    end

    # 遅延評価用の値を適用する
    def apply(a : T)
      if fst <= a
        true
      elsif snd < a
        @sum -= (fst - a) * cnt
        @fst = a
        true
      else
        false
      end
    end
  end

  getter st : SegmentTreeBeats(Node(T))
  getter n : Int32

  def initialize(values : Array(T))
    @n = values.size
    nodes = values.map { |v| Node.new(v) }
    @st = SegmentTreeBeats(Node(T)).new(nodes)
  end

  def [](r : Range(Int::Primitive?, Int::Primitive?))
    lo = r.begin || 0
    hi = r.end.try(&.+(1 - r.excludes_end?.to_unsafe)) || n
    ans = T.zero
    st.query(lo, hi) do |node|
      ans += node.sum
    end
    ans
  end

  def []=(r : Range(Int::Primitive?, Int::Primitive?), x : T)
    lo = r.begin || 0
    hi = r.end.try(&.+(1 - r.excludes_end?.to_unsafe)) || n
    st.apply(lo, hi, x)
  end
end

class Array
  def to_range_chmin_range_sum
    RangeChminRangeSum.new(self)
  end
end
