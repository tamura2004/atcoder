class Node(T)
  getter lo : self?
  getter hi : self?
  getter up : self?
  getter val : T
  getter pri : Int64

  def initialize(@val : T, @up = nil, @lo = nil, @hi = nil)
    @pri = rand(Int64::MAX)
  end

  def <<(x)
    if x < val
      if l = lo
        l << x
      else
        @lo = Node.new(x, self)
      end
    else
      if h = hi
        h << x
      else
        @hi = Node.new(x, self)
      end
    end
  end

  def to_s
    (lo.try(&.to_s) || "") + val.to_s + (hi.try(&.to_s) || "")
  end

  def print
    lo.try &.print
    print val
    hi.try &.print
  end
end
