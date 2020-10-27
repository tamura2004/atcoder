class Node(T)
  property lo : self?
  property hi : self?
  getter val : T
  getter pri : Int64

  def initialize(@val : T, @lo = nil, @hi = nil)
    @pri = rand(Int64::MAX)
    # @pri = rand(6_i64)
  end

  def insert(x : T) : Node(T)
    if x < val
      if l = lo
        l.insert(x).tap do |c|
          l.lo, c.hi = c.hi, l if c.pri < l.pri
        end
      else
        @lo = Node.new(x)
      end
    else
      if h = hi
        h.insert(x).tap do |c|
          h.hi, c.lo = c.lo, h if c.pri < h.pri
        end
      else
        @hi = Node.new(x)
      end
    end
  end

  def to_s
    (lo.try(&.to_s) || "") + val.to_s + (hi.try(&.to_s) || "")
  end

  def debug
    puts "#{val} #{pri}"
    lo.try &.debug
    hi.try &.debug
  end
end

t = Node.new(5)
10.times do |i|
  t = t.insert(i)
end
t.debug