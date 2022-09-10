require "crystal/graph"
require "crystal/priority_queue"

# 逆順
# コスト大きい順（貪欲）
# コストは変動するので、常に取り除いた後の最小コストを
# 求める必要がある。PQでは途中が抜けないし・・・とあきらめ
# たが、重複管理しながら更新した値を保存してしまえばよい。

n,m = gets.to_s.split.map(&.to_i)
a = gets.to_s.split.map(&.to_i64)

g = Graph.new(n)
m.times do
  g.read
end

costs = Array.new(n, 0_i64)
g.each do |v|
  g.each(v) do |nv|
    costs[v] += a[nv]
  end
end

pq = PriorityQueue(Tuple(Int64,Int32)).lesser
costs.each_with_index do |cost, v|
  pq << {cost, v}
end

seen = Array.new(n, false)
ans = 0_i64

while pq.size > 0
  cost, v = pq.pop
  next if seen[v]
  seen[v] = true
  chmax ans, cost

  g.each(v) do |nv|
    next if seen[nv]
    costs[nv] -= a[v]
    pq << {costs[nv], nv}
  end
end

pp ans
