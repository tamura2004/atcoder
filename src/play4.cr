require "crystal/mod_int"
require "crystal/matrix"
require "benchmark"

record M, a : ModInt, b : ModInt, c : ModInt, d : ModInt do
  def *(x : self)
    M.new(a * x.a + b * x.c, a * x.b + b * x.d, c * x.a + d * x.c, c * x.b + d * x.d)
  end

  def **(k : Int)
    ans = M.new(1.to_m, 0.to_m, 0.to_m, 1.to_m)
    tot = self
    while k > 0
      if k.odd?
        ans *= tot
      end
      tot *= tot
      k >>= 1
    end
    ans
  end
end

Benchmark.ips do |bm|
  bm.report("record") do
    m = M.new(1.to_m,1.to_m,1.to_m,0.to_m)
    100000.times do
      mm = m ** 1000000000
    end
  end

  bm.report("Matrix") do
    m = Matrix.new([
      [1.to_m,1.to_m],
      [1.to_m,0.to_m]
    ])
    100000.times do
      mm = m ** 1000000000
    end
  end
end
