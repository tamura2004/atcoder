require "crystal/modint9"

# f(x) = a*x + b
# f + g = g(f(x))
# x * f = f(x) 
record F, a : ModInt, b : ModInt do
  def +(other : F) : F
    F.new(a * other.a, other.a * b + other.b)
  end

  def self.zero
    F.new(1.to_m, 0.to_m)
  end

  def **(n : Int32) : F
    base = self
    ans = F.zero
    while n > 0
      if n.odd?
        ans += base
      end
      n //= 2
      base += base
    end
    ans
  end

  def [](x)
    a * x + b
  end
end