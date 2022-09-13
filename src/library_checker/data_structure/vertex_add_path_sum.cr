require "crystal/graph"
require "crystal/graph/h_l_decomposition"
require "crystal/segment_tree"

n, q = gets.to_s.split.map(&.to_i)
a = gets.to_s.split.map(&.to_i64)
g = Graph.new(n)
(n-1).times do
  g.read origin: 0
end
hld = HLDecomposition.new(g, 0)
st = n.to_st_sum

n.times do |v|
  st[hld.enter[v]] = a[v]
end

q.times do
  cmd, x, y = gets.to_s.split.map(&.to_i64)
  case cmd
  when 0
    v = x.to_i
    st[hld.enter[v]] += y
  when 1
    v = x.to_i
    nv = y.to_i
    ans = 0_i64
    hld.path_query(v, nv, edge: false) do |v, nv|
      ans += st[v..nv]
    end
    pp ans
  end
end
