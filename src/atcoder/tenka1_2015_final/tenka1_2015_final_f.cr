require "crystal/graph"
require "crystal/graph/euler_tour"
require "crystal/graph/lca"

n = gets.to_s.to_i64
g = Graph.new(n)

(n-1).times do
  g.read
end

lca = Lca.new(g, 0)
enter, leave = EulerTour.new(g).solve(0)

q = gets.to_s.to_i64
q.times do
  m, k = gets.to_s.split.map(&.to_i)
  a = gets.to_s.split.map(&.to_i.pred)
  a.sort_by! { |i| enter[i] }

  ans = (m-k+1).times.max_of do |i|
    j = i + k - 1
    t = lca.solve(a[i], a[j])
    lca.depth[t.not_nil!]
  end

  pp ans
end
