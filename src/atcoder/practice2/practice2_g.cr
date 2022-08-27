require "crystal/graph"
require "crystal/graph/scc"

n, m = gets.to_s.split.map(&.to_i)
g = Graph.new(n)

m.times do
  g.read(origin: 1, both: false)
end

scc = SCC.new(g).solve
puts scc.size
scc.each do |a|
  puts "#{a.size} #{a.join(' ')}"
end
