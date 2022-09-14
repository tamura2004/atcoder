require "crystal/modint9"
require "crystal/matrix"
require "crystal/segment_tree"
require "crystal/graph"
require "crystal/graph/h_l_decomposition"
require "crystal/indexable"

alias X = Matrix(ModInt)

n, q = gets.to_s.split.map(&.to_i)
values = Array.new(n) do
  a, b = gets.to_s.split.map(&.to_i64.to_m)
  X.new([[a, b], [0.to_m, 1.to_m]])
end

g = Graph.new(n)
(n - 1).times do
  g.read origin: 0
end

hld = HLDecomposition.new(g, 0)

values = values.zip(0..).sort_by! { |m,v| hld.enter[v] }.map(&.first)

st = SegmentTree(X).new(
  values: values,
  unit: X.eye(2),
  fx: ->(x : X, y : X) { y }
)

pp g

q.times do
  cmd, x, y, z = gets.to_s.split.map(&.to_i64)
  case cmd
  when 0
    st[x] = X.new([[y.to_m, z.to_m], [0.to_m, 1.to_m]])
  when 1
    lca = hld.lca(x, y)

    hld.path_query(x, lca) do |lo, hi|
      mat = st[lo..hi]
      pp! mat
    end
    
    hld.path_query(lca, y) do |lo, hi|
      mat = st[lo..hi]
      pp! mat
    end

    # pp ans
  end
end
