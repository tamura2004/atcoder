require "crystal/graph"
require "crystal/graph/bipartite"

n, m = gets.to_s.split.map(&.to_i64)
g = Graph.new(n)
m.times do
  v, nv = gets.to_s.split.map(&.to_i)
  g.add v, nv
end

begin
  ans = n ** 2
  cnt = Bipartite.new(g).solve.tally.values.map(&.to_i64)
  cnt.each do |i|
    ans -= i ** 2
  end
  ans //= 2
  ans -= m
  pp ans
rescue
  pp 0
end