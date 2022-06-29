struct MinusOneAsInf
  include Comparable(self)
  include Comparable(Int)

  getter v : Int64

  def initialize(v)
    @v = v.to_i64
  end

  def <=>(b : self)
    v == -1 ? 1 : b.v == -1 ? -1 : v <=> b.v
  end

  def <=>(b : Int)
    v == -1 ? 1 : v <=> b
  end
end

struct Int
  include Comparable(MinusOneAsInf)

  def <=>(b : MinusOneAsInf)
    b.v == -1 ? -1 : self <=> b.v
  end
end

x = MinusOneAsInf.new(100)
y = MinusOneAsInf.new(-1)
z = 100
w = -1

a = [z,x,y,z,w]
pp a.sort
