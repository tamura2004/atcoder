require "crystal/matrix"

# 全探索
n, m = gets.to_s.split.map(&.to_i64)
g = Matrix(Int64).zero(n)

m.times do
  v, nv = gets.to_s.split.map(&.to_i.pred)
  g[v][nv] = 1_i64
  g[nv][v] = 1_i64
end

ans = (g ** 3).tr // 6
pp ans
  