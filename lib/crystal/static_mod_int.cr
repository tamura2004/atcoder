# 自動でMODを取る構造体
struct StaticModInt(M)
  getter v : Int64
  delegate to_i64, to_s, to_m, inspect, to: v
  @@memo = Hash(Int64,Int64).new

  def initialize(v)
    @v = v.to_i64 % M
  end

  {% for op in %w(+ - *) %}
    def {{op.id}}(b)
      typeof(self).new v {{op.id}} (b.to_i64 % M)
    end
  {% end %}

  def **(b)
    a = self
    ans = typeof(self).new(1)
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

  # メモ化
  def //(b)
    if rev = @@memo[b]?
      return self * typeof(self).new(rev)
    end

    rev = typeof(self).new(b).inv
    @@memo[b] = rev.to_i64
    self * rev
  end

  def self.zero
    new(0)
  end

  def ==(b)
    b.try &.to_i64.==(v)
  end
end
