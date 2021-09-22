require "crystal/bit_grid_graph/graph"
include BitGridGraph

n = gets.to_s.to_i
k = gets.to_s.to_i

s = Array.new(n){ gets.to_s.tr(".#","01") }
g = Graph.new(s)

seen = Hash(Graph,Bool).new(false)
q = Deque(Graph).new

g.each do |y,x|
  next if g[y,x] == 1

  ng = Graph.new(n,n)
  ng[y,x] = 1
  q << ng
  seen[ng] = true
end

ans = 0_i64

while q.size > 0
  v = q.shift

  if v.popcount == k
    ans += 1
  else
    v.next_candidate do |nv|
      next if nv & g.to_i64 != 0
      next if seen[nv]
      seen[nv] = true
      q << nv
    end
  end
end

pp ans
