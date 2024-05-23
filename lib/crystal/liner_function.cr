# f(x) = a*x + b
# f + g = g(f(x))
# x * f = f(x) 
struct LinerFunction(T)
  getter a : T
  getter b : T

  def initialize(@a, @b)
  end

  def +(other : self)
    self.class.new(a * other.a, other.a * b + other.b)
  end

  def *(other)
    other * a + b
  end
end

alias F = LinerFunction
