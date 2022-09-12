require "crystal/graph"
require "crystal/graph/tsort"

n, m = gets.to_s.split.map(&.to_i)
g = Graph.new(n)
m.times do
  g.read both: false
end

tsort = Tsort.new(g).solve
dp = Array.new(n, 0)

tsort.reverse_each do |v|
  g.each(v) do |nv|
    chmax dp[v], dp[nv] + 1
  end
end

pp dp.max