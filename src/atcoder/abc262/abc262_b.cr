# 全探索
n, m = gets.to_s.split.map(&.to_i64)
g = Array.new(n) { Array.new(n, false) }

m.times do
  v, nv = gets.to_s.split.map(&.to_i.pred)
  g[v][nv] = true
  g[nv][v] = true
end

ans = 0_i64
(0...n).to_a.each_combination(3) do |(a,b,c)|
  ans += 1 if g[a][b] && g[b][c] && g[c][a]
end

pp ans
  