require "crystal/graph"
require "crystal/priority_queue"

n,m,k = gets.to_s.split.map(&.to_i64)
g = n.to_g
m.times do
  v, nv = gets.to_s.split.map(&.to_i64)
  g.add v, nv
end

pq = PriorityQueue(Tuple(Int64,Int32)).greater

k.times do
  v, h = gets.to_s.split.map(&.to_i64)
  v = v.to_i - 1
  pq << {h, v}
end

ans = Array.new(n, -1_i64)
cnt = 0_i64

while pq.size > 0 && cnt < n
  h, v = pq.pop
  next if ans[v] != -1
  ans[v] = h
  cnt += 1

  next if h <= 0

  g.each(v) do |nv|
    next if ans[nv] != -1
    pq << {h - 1, nv}
  end
end

pp ans.count(&.>= 0)
puts ans.zip(1..).select(&.first.!= -1).map(&.last).join(" ")