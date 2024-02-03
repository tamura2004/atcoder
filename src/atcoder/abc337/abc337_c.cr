require "crystal/graph"
require "crystal/graph/tsort"

n = gets.to_s.to_i64
a = gets.to_s.split.map(&.to_i64)
g = n.to_g

a.each_with_index do |pv, v|
  next if pv == -1
  pv -= 1
  g.add pv, v, origin: 0, both: false
end

puts Tsort.new(g).solve.map(&.succ).join(" ")
