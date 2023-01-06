require "crystal/graph"
require "crystal/graph/h_l_decomposition"
require "crystal/segment_tree"

n, x = gets.to_s.split.map(&.to_i64)
g = Graph.new(n)
(n-1).times do
  v,nv,cost = gets.to_s.split.map(&.to_i64)
  g.add v, nv, cost
end
hld = HLDecomposition.new(g)

# 親方向の頂点へ向かう辺のコスト
edge_weight = Array.new(n, 0_i64)
dfs = uninitialized (Int32, Int32) -> Nil
dfs = -> (v : Int32, pv : Int32) do
  g.each_with_cost(v) do |nv, cost|
    next if nv == pv
    dfs.call(nv, v)
    edge_weight[hld.enter[nv]] = cost    
  end
end
dfs.call(0, -1)
st = edge_weight.to_st_sum

(0...n-1).each do |v|
  (v+1...n).each do |nv|
    quit "Yes" if hld.path_query_with_st(v,nv,st) == x
  end
end
puts "No"
