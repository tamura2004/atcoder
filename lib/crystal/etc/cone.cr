struct Cone(T)
  getter x : T
  getter r : T
  getter h : T
  getter v : T

  def initialize(@x : T, @r : T, @h : T)
    @v = r * r * Math::PI * h / 3.0
  end

  def height(a : T)
    return T.zero if a <= x || x + h <= a
    x + h - a
  end
  
  def radius(a : T)
    return T.zero if a <= x || x + h <= a
    height(a) * r / h
  end
  
  def volume(a : T)
    if a <= x
      T.zero
    elsif x + h <= a
      v
    else
      v - radius(a) * radius(a) * Math::PI * height(a) / 3.0 
    end
  end
end