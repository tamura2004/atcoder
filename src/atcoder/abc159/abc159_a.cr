n, k = gets.to_s.split.map(&.to_i64)
g = Array.new(n) { gets.to_s.split.map(&.to_i64) }

n.times do |i|
  n.times do |j|
    g[i][j] = Int64::MAX//4 if g[i][j] == 0
  end
end

n.times do |k|
  n.times do |i|
    n.times do |j|
      chmin g[i][j], g[i][k] + g[k][j]
    end
  end
end

q = gets.to_s.to_i64
q.times do
  v, nv = gets.to_s.split.map(&.to_i64.pred)
  v %= n
  nv %= n
  puts g[v][nv] == Int64::MAX//4 ? -1 : g[v][nv]
end
