struct ModInt
  N   = 100_000
  MOD = 10_i64 ** 9 + 7
  # MOD = 998_244_353_i64

  class_getter f = Array(ModInt).new(N)
  getter v : Int64

  def self.f(n)
    f << 1.to_m if f.empty?
    f.size.upto(n) do |i|
      f << f.last * i
    end
    f[n]
  end

  def self.p(n, k)
    n.f // (n - k).f
  end

  def self.c(n, k)
    p(n, k) // k.f
  end

  def self.h(n, k)
    c(n + k - 1, k)
  end

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
    v == b.to_i64
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

  def f
    ModInt.f(self)
  end

  def p(k)
    ModInt.p(self, k)
  end

  def c(k)
    ModInt.c(self, k)
  end

  def h(k)
    ModInt.h(self, k)
  end
end
