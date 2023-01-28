# tsort
require "crystal/graph"
require "crystal/graph/tsort"

g = BaseGraph(String).new
n = gets.to_s.to_i
n.times do
  s, t = gets.to_s.split
  g.add s, t, both: false
end

puts Tsort.new(g).has_loop? ? :No : :Yes
