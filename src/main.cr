require "crystal/bit_grid_graph/graph"
require "crystal/union_find_tree"
include BitGridGraph

n = gets.to_s.to_i
k = gets.to_s.to_i

s = Array.new(n){ gets.to_s.tr(".#","01") }
g = Graph.new(s)

seen = Hash(Int64,Bool).new(false)
q = Deque(Int64).new

g.each do |y,x|
  next if g[y,x] == 1

  ng = Graph.new(n,n)
  ng[y,x] = 1
  q << ng.to_i64
  seen[ng.to_i64] = true
end

pp q.size
exit

ans = 0_i64

while q.size > 0
  v = q.shift

  if v.popcount == k
    ans += 1
  else
    Graph.new(n,n,v).next_candidate do |nv|
      next if nv & g.to_i64 != 0
      next if seen[nv]
      seen[nv] = true
      q << nv
    end
  end
end

pp ans
      

