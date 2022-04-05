# modint
struct ModInt
  MOD = 998_244_353_i64
  getter v : Int64

  def initialize(v)
    @v = v.to_i64 % MOD
  end

  {% for op in %w(+ - *) %}
    def {{op.id}}(b)
      ModInt.new(v {{op.id}} (b.to_i64 % MOD))
    end
  {% end %}

  def **(b)
    a = self
    ans = 1.to_m
    while b > 0
      ans *= a if b.odd?
      b //= 2
      a *= a
    end
    return ans
  end

  def inv
    self ** (MOD - 2)
  end

  def //(b)
    self * b.to_m.inv
  end

  def self.zero
    new(0)
  end

  def ==(b)
    # v == b.to_i64
    b.try &.to_i64.==(v)
  end

  def to_m
    self
  end

  delegate to_i64, to: v
  delegate to_s, to: v
  delegate inspect, to: v
end

struct Int
  def to_m
    ModInt.new(to_i64)
  end
end
