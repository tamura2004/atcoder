require "crystal/graph"
require "crystal/graph/scc"

n, m = gets.to_s.split.map(&.to_i)
g = Graph.new(n)

m.times do
  g.read both: false
end

scc = SCC.new(g).solve

dp = Array.new(n, false)

cnt = Array.new(n, 0)
scc.each do |a|
  a.each do |i|
    cnt[i] = a.size
    dp[i] = a.size >= 2
  end
end

scc.reverse_each do |a|
  a.each do |v|
    g.each(v) do |nv|
      dp[v] ||= dp[nv]
    end
  end
end

ans = dp.count(true)
pp ans