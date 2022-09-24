require "crystal/union_find"
require "crystal/priority_queue"

n, m = gets.to_s.split.map(&.to_i)
xs = gets.to_s.split.map(&.to_i64)
ys = gets.to_s.split.map(&.to_i64)
edges = Array.new(m) do
  v, nv, cost = gets.to_s.split.map(&.to_i64)
  v = v.to_i.pred
  nv = nv.to_i.pred
  {cost, v, nv}
end

sky = n
sea = n + 1

# 道路のみ
ans = 0_i64
pq = PQ(Tuple(Int64,Int32,Int32)).lesser
uf = n.to_uf

edges.each do |edge|
  pq << edge
end

while pq.size > 0
  cost, v, nv = pq.pop
  next if uf.same?(v,nv)
  ans += cost
  uf.unite(v, nv)
end

ans = Int64::MAX if uf.size(0) != n

# 道路+空港
ans1 = 0_i64
pq = PQ(Tuple(Int64,Int32,Int32)).lesser
uf = (n + 1).to_uf

n.times do |i|
  pq << {xs[i], sky, i}
end

edges.each do |edge|
  pq << edge
end

while pq.size > 0
  cost, v, nv = pq.pop
  next if uf.same?(v,nv)
  ans1 += cost
  uf.unite(v, nv)
end

if uf.size(0) == n + 1
  chmin ans, ans1
end

# 道路+空港
ans2 = 0_i64
pq = PQ(Tuple(Int64,Int32,Int32)).lesser
uf = (n + 1).to_uf

n.times do |i|
  pq << {ys[i], sky, i}
end

edges.each do |edge|
  pq << edge
end


while pq.size > 0
  cost, v, nv = pq.pop
  next if uf.same?(v,nv)
  ans2 += cost
  uf.unite(v, nv)
end

if uf.size(0) == n + 1
  chmin ans, ans2
end

# 道路+空港
ans3 = 0_i64
pq = PQ(Tuple(Int64,Int32,Int32)).lesser
uf = (n + 2).to_uf

n.times do |i|
  pq << {xs[i], sky, i}
  pq << {ys[i], sea, i}
end

edges.each do |edge|
  pq << edge
end


while pq.size > 0
  cost, v, nv = pq.pop
  next if uf.same?(v,nv)
  ans3 += cost
  uf.unite(v, nv)
end

if uf.size(0) == n + 2
  chmin ans, ans3
end

pp ans
