# xi+1 = axi + b
# xi+1 - y = a(xi - y)
# y = b + ay
# y = b / (1 - a)
# zi = xi - b / (1 - a)は
# 初項s-b(1-a)公比aの等比数列
# 一般項は
# zi = (s - b/(1-a)) * a^i
# xi = (s - b/(1-a)) * a^i + b/(1-a)
# xk = Gを解く
# G = (s - b/(1-a)) * a^k + b/(1-a)
# (G - b/(1-a)) // (ss - b/(1-a)) = a^k

require "crystal/number_theory/ext_gcd"
require "crystal/number_theory/baby_step_giant_step"
include NumberTheory
# 自動でMODを取る構造体

struct ModInt
  @@m = 100_i64
  class_property m : Int64
  getter v : Int64
  delegate to_i64, to_s, to_m, inspect, to: v

  def initialize(v)
    @v = v.to_i64 % @@m
  end

  {% for op in %w(+ - *) %}
    def {{op.id}}(b)
      self.class.new v {{op.id}} (b.to_i64 % @@m)
    end
  {% end %}

  def **(b)
    a = self
    ans = self.class.new(1)
    while b > 0
      ans *= a if b.odd?
      b >>= 1
      a *= a
    end
    return ans
  end

  def inv
    self ** (@@m - 2)
  end

  def //(b)
    self * self.class.new(b).inv
  end

  def self.zero
    new(0)
  end

  def ==(b)
    b.try &.to_i64.==(v)
  end
end

t = gets.to_s.to_i
t.times do
  p, a, b, s, g = gets.to_s.split.map(&.to_i64)
  pp! [p,a,b,s,g]
  ModInt.m = p

  if a == 1
    if b == 0
      if s == g
        pp 0
      else
        pp -1
      end
    else
      ans = (g - s) // b
      pp ans
    end
  else
    x = ModInt.new(a)
    al = ModInt.new(b) // (ModInt.new(1) - a)
    y = (ModInt.new(g) - al) // (ModInt.new(s) - al)
    pp BabyStepGiantStep.solve(x, y, p)
  end
end
