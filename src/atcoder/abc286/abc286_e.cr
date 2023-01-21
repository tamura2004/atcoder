# 最短経路はワーシャルフロイド
# 最短パスの復元？
# 距離と価値のマイナスのタプル

INF = Int64::MAX//4

n = gets.to_s.to_i64
g = make_array({INF,INF}, n, n)
a = gets.to_s.split.map(&.to_i64)
s = Array.new(n){gets.to_s}

# make a graph
n.times do |v|
  n.times do |nv|
    if s[v][nv] == 'Y'
      g[v][nv] = {1_i64, -a[nv]}
    end
  end
end

# wf
n.times do |k|
  n.times do |i|
    next if k == i
    n.times do |j|
      next if i == j || k == j
      cnt = {g[i][k][0] + g[k][j][0], g[i][k][1] + g[k][j][1]}
      chmin g[i][j], cnt
    end
  end
end

q = gets.to_s.to_i
q.times do
  v, nv = gets.to_s.split.map(&.to_i.pred)
  cnt = g[v][nv][0]
  cost = a[v] - g[v][nv][1]
  if cnt == INF
    puts "Impossible"
  else
    puts "#{cnt} #{cost}"
  end
end
