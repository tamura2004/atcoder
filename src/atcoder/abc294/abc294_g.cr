require "crystal/graph"
require "crystal/graph/h_l_decomposition"
require "crystal/segment_tree"

n = gets.to_s.to_i
g = n.to_g
(n - 1).times do
  v, nv, cost = gets.to_s.split.map(&.to_i64)
  g.add v, nv, cost
end

hld = HLDecomposition.new(g, 0)
st = n.to_st_sum

edge_to_v = Hash(Int32,Int32).new

dfs = uninitialized (Int32, Int32) -> Nil
dfs = ->(v : Int32, pv : Int32) do
  g.each_cost_with_edge_index(v) do |nv, cost, i|
    next if nv == pv
    dfs.call(nv, v)
    st[hld.enter[nv]] = cost
    edge_to_v[i] = nv
  end
end
dfs.call(0, -1)

q = gets.to_s.to_i64
q.times do
  cmd, i, j = gets.to_s.split.map(&.to_i64)
  case cmd
  when 1
    st[hld.enter[edge_to_v[i.pred]]] = j
  when 2
    pp hld.path_query_with_st(i.pred, j.pred, st)
  end
end

# pp edge_to_v