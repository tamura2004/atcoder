# 動的modint
struct ModInt
  class_property mod : Int64 = 998_244_353_i64
  getter v : Int64
  delegate to_i64, to_s, inspect, to: v

  def initialize(v)
    @v = v.to_i64 % @@mod
  end

  {% for op in %w(+ - *) %}
    def {{op.id}}(b)
      ModInt.new v {{op.id}} (b.to_i64 % @@mod)
    end
  {% end %}

  def self.zero
    new(0)
  end

  def to_m
    self
  end
end

struct Int
  def to_m
    ModInt.new(to_i64)
  end

  def to_mod
    ModInt.mod = to_i64
  end
end