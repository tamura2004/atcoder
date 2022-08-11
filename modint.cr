# 自動でMODを取る構造体
struct StaticModInt(M)
  getter v : Int64
  delegate to_i64, to_s, to_m, inspect, to: v

  def initialize(v)
    @v = v.to_i64 % M
  end

  {% for op in %w(+ - *) %}
    def {{op.id}}(b)
      StaticModInt(M).new v {{op.id}} (b.to_i64 % M)
    end
  {% end %}

  def **(b)
    a = self
    ans = 1.to_m(M)
    while b > 0
      ans *= a if b.odd?
      b >>= 1
      a *= a
    end
    return ans
  end

  def inv
    self ** (M - 2)
  end

  def //(b)
    self * b.to_m(M).inv
  end

  def self.zero
    new(0)
  end

  def ==(b)
    b.try &.to_i64.==(v)
  end
end

MOD = 998_244_353_i64

struct Int
  def to_m
    StaticModInt(MOD).new(to_i64)
  end
end

alias ModInt = StaticModInt(MOD)
