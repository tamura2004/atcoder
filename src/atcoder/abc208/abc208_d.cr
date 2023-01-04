require "crystal/matrix"

n, m = gets.to_s.split.map(&.to_i64)
inf = Int64::MAX//4
g = Matrix(Int64).new(C.unit(n), inf)
n.times { |i| g[i, i] = 0_i64 }

m.times do
  v, nv, cost = gets.to_s.split.map(&.to_i64)
  v -= 1
  nv -= 1
  g[v, nv] = cost
end

ans = 0_i64
n.times do |k|
  n.times do |v|
    n.times do |nv|
      chmin g[v, nv], g[v, k] + g[k, nv]
    end
  end
  ans += g.select(&.!= inf).sum
end

pp ans
