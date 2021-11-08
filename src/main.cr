require "crystal/graph/connected_decomposition"
require "crystal/modint9"

n, m = gets.to_s.split.map(&.to_i)
g = Graph.new(n)
m.times do
  g.read
end

vs, es = CD.new(g).solve
ans = 1.to_m
vs.zip(es).each do |v,e|
  if v == e
    ans *= 2
  else
    pp 0
    exit
  end
end

pp ans