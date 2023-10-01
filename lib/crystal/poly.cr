require "crystal/tuple"

class Poly
  getter a : Set(Tuple(Int32, Int32))
  getter h : Int32
  getter w : Int32
  delegate "<<", to: a

  def initialize
    @a = Set(Tuple(Int32, Int32)).new
    @h = @w = 0
  end

  def clip
    x = a.map(&.[0]).min
    y = a.map(&.[1]).min
    b = Set(Tuple(Int32, Int32)).new
    a.each do |v|
      b << (v - ({x, y}))
    end
    @a = b
    @w = a.map(&.[0]).max + 1
    @h = a.map(&.[1]).max + 1
  end

  def rot90
    b = Set(Tuple(Int32, Int32)).new
    a.each do |x, y|
      b << ({-y, x})
    end
    @a = b
    clip
  end

  def +(v)
    b = Set(Tuple(Int32, Int32)).new
    a.each do |u|
      b << v + u
    end
    @a = b
  end
end
