require "crystal/union_find_tree"
require "crystal/priority_queue"

n,m = gets.to_s.split.map(&.to_i)
q = PriorityQueue(Tuple(Int64,Int32,Int32)).lesser
uf = UnionFindTree.new(n+1)

m.times do 
  cost, v, nv = gets.to_s.split.map(&.to_i64)
  v = v.to_i - 1
  nv = nv.to_i
  q << { cost, v, nv }
end

ans = 0_i64
while q.size > 0
  cost, v, nv = q.pop
  next if uf.same?(v, nv)
  uf.unite(v, nv)
  ans += cost
end

if uf.gsize == 1
  pp ans
else
  pp -1
end
  
