require "crystal/graph"
require "crystal/graph/h_l_decomposition"

n = gets.to_s.to_i
g = Graph.new(n)
(n-1).times do
  g.read
end
hld = HLDecomposition.new(g, 0)

q = gets.to_s.to_i
q.times do
  v = gets.to_s.split.map(&.to_i.pred)[1..]
  v.sort_by!{|i| hld.enter[i]}

  m = v.size
  cnt = 0_i64
  m.times do |i|
    hld.path_query(v[i-1], v[i]) do |lo, hi|
      cnt += (lo..hi).size
    end
  end

  pp cnt // 2
end

