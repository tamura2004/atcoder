require "crystal/weighted_flow_graph/min_cost_flow"
include WeightedFlowGraph

red, green, blue = gets.to_s.split.map(&.to_i64)
n = 1001

g = Graph.new(n)

source = 0
sink = 1000

g.add source, 400, red, 0
g.add source, 500, green, 0
g.add source, 600, blue, 0

(1...1000).each do |v|
  g.add v, sink, 1, 0
end

[400, 500, 600].each do |v|
  (1...1000).each do |nv|
    cost = (v - nv).abs
    g.add v, nv, 1, cost
  end
end

ans = MinCostFlow.new(g).solve(source, sink, red + green + blue)
pp ans