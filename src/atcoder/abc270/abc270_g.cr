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
  ModInt.m = p
  a,b,s,g = {a,b,s,g}.map{|v| ModInt.new(v) }

  if a == 1
    ans = (g - s) // b
    pp ans
  else
    x = a
    al = b // (ModInt.new(1) - a)
    y = (g - al) // (s - al)
    pp BabyStepGiantStep.solve(x, y, p)
  end
end
