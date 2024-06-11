class DynamicSegmentTree(T)
  class Node(T)
    HI = 2_i64 ** 3
    property left : Node(T)?
    property right : Node(T)?
    getter lo : Int64
    getter hi : Int64
    getter val : T

    def initialize(@val = T.zero, @lo = 0_i64, @hi = HI)
      @val = T.zero
      @left = nil.as(Node(T)?)
      @right = nil.as(Node(T)?)
    end

    def set(i : Int64, val : T, lo : Int64 = 0_i64, hi : Int64 = HI) : self
      if hi - lo == 1
        @val = val
        return self
      end
  
      mid = (lo + hi) // 2
      if i < mid
        @left = (left || Node(T).new(val, lo, mid)).set(i, val, lo, mid)
      else
        @right = (right || Node(T).new(val, mid, hi)).set(i, val, mid, hi)
      end

      @val = left_value + right_value
      self
    end

    private def left_value
      left.try &.val || T.zero
    end

    private def right_value
      right.try &.val || T.zero
    end

    def get(lo : Int64, hi : Int64) :  T
      pp! [lo, hi, @lo, @hi]
      return T.zero if hi <= @lo || @hi <= lo
      return @val if lo == @lo && @hi == hi
      if @lo <= lo && hi <= @hi
        left_get(lo, hi) + right_get(lo, hi)
      else
        mid = (lo + hi) // 2
        left_get(lo, mid) + right_get(mid, hi)
      end
    end

    private def left_get(lo : Int64, hi : Int64)
      left.try &.get(lo, hi) || T.zero
    end

    private def right_get(lo : Int64, hi : Int64)
      right.try &.get(lo, hi) || T.zero
    end

    def to_a
      "(#{[lo, hi, val]} #{left_to_a} #{right_to_a})"
    end

    private def left_to_a
      left.try &.to_a || "nil"
    end

    private def right_to_a
      right.try &.to_a || "nil"
    end
  end

  getter root : Node(T)

  def initialize
    @root = Node(T).new
  end

  def set(i : Int64, val : T)
    root.set(i, val)
  end

  def get(lo : Int64, hi : Int64) : T
    root.get(lo, hi)
  end

  def to_a
    root.to_a
  end
end
