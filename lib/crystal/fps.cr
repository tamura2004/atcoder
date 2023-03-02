require "crystal/modint9"
require "crystal/ntt"

struct FPS
  getter a : Array(ModInt)
  delegate size, "[]", to: a

  def initialize(a)
    @a = a.map(&.to_m)
  end

  def *(b : self)
    FPS.new NTT.conv(a, b.a)
  end

  {% for op in %w(+ -) %}
    def {{op.id}}(b : self)
      deg = Math.max(a.size, b.size)
      ans = a.dup
      while ans.size < deg
        ans << 0.to_m
      end
      b.a.each_with_index do |v, i|
        ans[i] {{op.id}}= v
      end
      FPS.new ans
    end
  {% end %}

  def *(b : Int | ModInt)
    FPS.new a.map(&.*(b))
  end

  def inv
    raise "定数項が０です（未定義エラー）" if @a[0].to_i64.zero?
    # (g - Gi) ^ 2 = 0 (mod x ^ (2 ** (i + 1)))
    # g^2 - 2gGi + Gi^2 = 0 (mod x ^ (2 ** (i + 1)))
    # g - 2Gi + fGi^2 = 0 (mod x ^ (2 ** (i + 1)))
    # Gi+1 = 2Gi - fGi^2 (mod x ^ (2 ** (i + 1)))

    deg = Math.ilogb(Math.pw2ceil(a.size))
    g = FPS.new([a[0].inv])
    deg.times do
      g = g * 2 - g * g * self
    end
    FPS.new g.a.first(size)
  end
end
