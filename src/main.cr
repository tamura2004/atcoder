# require "crystal/weighted_flow_graph/min_cost_flow"
# include WeightedFlowGraph

# red, green, blue = gets.to_s.split.map(&.to_i64)
# n = 803

# g = Graph.new(n)

# source = 801
# sink = 802

# g.add source, 300, red, 0
# g.add source, 400, green, 0
# g.add source, 500, blue, 0

# (0..800).each do |v|
#   g.add v, sink, 1, 0
# end

# [300,400,500].each do |v|
#   (-300..300).each do |offset|
#     nv = v + offset
#     cost = offset.abs
#     g.add v, nv, 1, cost
#   end
# end

# ans = MinCostFlow.new(g).solve(source, sink, red + green + blue)
# pp ans

(-10..10).each do |v|
  pp v
end
