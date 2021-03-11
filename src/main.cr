# WFで全点間最大距離求める
# 各辺(u,v)について、k != u,v
# (u,k) + (k,v) <= (u,v)なるkがあれば、
# 最短パスではない
macro chmin(target, other)
  {{target}} = ({{other}}) if ({{target}}) > ({{other}})
end

INF = 10_i64 ** 9
n,m = gets.to_s.split.map(&.to_i)
g = Array.new(n){ Array.new(n, INF) }
n.times{|i|g[i][i] = 0_i64}
e = Hash(Tuple(Int32,Int32),Int64).new do |h,k|
  h[k] = 0_i64
end

m.times do
  a,b,c = gets.to_s.split.map(&.to_i)
  a -= 1
  b -= 1
  g[a][b] = c.to_i64
  g[b][a] = c.to_i64
  e[{a,b}] = c.to_i64
end

n.times do |k|
  n.times do |i|
    n.times do |j|
      chmin g[i][j], g[i][k] + g[k][j]
    end
  end
end

ans = e.count do |key,cost|
  i,j = key
  g[i][j] != cost
end

pp ans
