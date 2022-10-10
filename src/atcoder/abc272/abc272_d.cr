# Mを斜辺とする直角三角形
# M = a ^ 2 + b ^ 2
# 0 <= a, b <= Mで全探索

require "crystal/math"
require "crystal/graph"
require "crystal/graph/dijkstra"
require "crystal/complex"
require "crystal/matrix"

n, m = gets.to_s.split.map(&.to_i64)

sq = Hash(Int64, Int64).new
(0i64..1000i64).map do |i|
  sq[i**2] = i
end

dir = [] of C
(1_i64..Math.isqrt(m)).each do |i|
  k = m - i ** 2
  next if k < 0
  next unless sq.has_key?(k)
  j = sq[k]
  dir << C.new(i, j)
end

# pp! dir

def outside?(z, n)
  z.x <= 0 || n < z.x || z.y <= 0 || n < z.y
end

g = BaseGraph(C).new
(1..n).each do |y|
  (1..n).each do |x|
    z = C.new(y, x)
    dir.each do |d|
      4.times do
        d *= 1.i
        nz = d + z
        next if outside?(nz, n)
        g.add z, nz, both: false
      end
    end
  end
end

ans = Matrix(Int64).build(n) { -1_i64 }
ans[0,0] = 0_i64

if g.n > 0
  dp = Dijkstra.new(g).solve(0)
  g.vs.zip(dp).each do |z, dist|
    if dist != Dijkstra::INF
      ans[z - (1.i + 1)] = dist
    end
  end
end

puts ans.a.map(&.join(" ")).join("\n")