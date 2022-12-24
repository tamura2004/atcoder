require "crystal/graph"
require "crystal/graph/scc"
require "crystal/bit_array"

n, m = gets.to_s.split.map(&.to_i)
g = Graph.new(n)
m.times do
  v, nv = gets.to_s.split.map(&.to_i64)
  g.add v, nv, both: false
end

scc = SCC.new(g).solve
dp = Array.new(n) { BitArray.new }

scc.each do |conn|
  s = conn.to_bit_array
  conn.each do |v|
    dp[v] += s
    
    g.each(v) do |nv|
      dp[nv] += dp[v]
    end
  end
end

ans = dp.sum(&.size)
pp ans