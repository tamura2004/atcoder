require "big"

# 剰余の法がInt64を越える場合に対応したModInt
#
# ```
# ModInt.mod = 10.to_big_i ** 100
# a = 10.to_m ** 200 + 7
# a * 2 # => 14
# ```
struct ModInt
  class_property mod : BigInt = 998_244_353.to_big_i
  getter v : BigInt
  delegate to_i, to_i64, to_big_i, to_s, inspect, to: v

  def initialize(v)
    @v = v.to_big_i % @@mod
  end

  {% for op in %w(+ - *) %}
    def {{op.id}}(b)
      ModInt.new v {{op.id}} (b.to_big_i % @@mod)
    end
  {% end %}

  # 累乗
  def pow(b)
    a = self
    ans = ModInt.new(1)
    while b > 0
      if b.odd?
        ans *= a
      end
      b >>= 1
      a *= a
    end
    ans
  end

  def **(b)
    pow(b)
  end

  def succ
    self + 1
  end

  def pred
    self - 1
  end

  def ==(b)
    v == b.to_big_i
  end
end

struct Int
  def to_m
    ModInt.new(to_big_i)
  end
end

alias DynamicModBigInt = ModInt