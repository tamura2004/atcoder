require "crystal/priority_queue"

n,m,q  = gets.to_s.split.map(&.to_i64)

g = Array.new(n){ [] of Tuple(Int32,Int64) }
m.times do
  a,b,c = gets.to_s.split.map(&.to_i)
  g[a-1] << { b-1, c.to_i64 }
  g[b-1] << { a-1, c.to_i64 }
end
x = gets.to_s.split.map(&.to_i64)

pq = PriorityQueue(Tuple(Int64,Int32,Int32)).lesser
nex = PriorityQueue(Tuple(Int64,Int32,Int32)).lesser
seen = Array.new(n){ false }
ans = 1

seen[0] = true
g[0].each do |v, cost|
  pq << { cost, 0, v}
end

q.times do |i|
  while pq.size > 0 && pq[0][0] <= x[i]
    c,v,nv = pq.pop
    next if seen[nv]
    seen[nv] = true
    ans += 1
    g[nv].each do |nnv, ncost|
      next if seen[nnv]
      nex << { ncost, nv, nnv }
    end
  end

  while nex.size > 0
    pq << nex.pop
  end

  puts ans
end


