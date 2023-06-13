require "crystal/graph"
require "crystal/graph/in_deg"
require "crystal/priority_queue"

n,m = gets.to_s.split.map(&.to_i)
g = n.to_g
m.times do
  v, nv = gets.to_s.split.map(&.to_i64)
  g.add v, nv, both: false
end

deg = InDeg.new(g).solve
pq = PriorityQueue(Int32).lesser

n.times do |i|
  pq << i if deg[i].zero?
end

ans = [] of Int32
while pq.size > 0
  v = pq.pop
  ans << v.succ
  g.each(v) do |nv|
    deg[nv] -= 1
    pq << nv if deg[nv].zero?
  end
end

puts ans.join(" ")

