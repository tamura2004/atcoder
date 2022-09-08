require "crystal/graph"
require "crystal/graph/tsort"

n, m = gets.to_s.split.map(&.to_i64)
g = Graph.new(n)

(n-1+m).times do
  g.read both: false
end

ord = Tsort.new(g).solve
dp = Array.new(n, 0)

ord.each do |v|
  g.each(v) do |nv|
    chmax dp[nv], dp[v] + 1
  end
end

ans = Array.new(n, 0)
ord.each do |v|
  g.each(v) do |nv|
    if dp[v] + 1 == dp[nv]
      ans[nv] = v + 1
    end
  end
end

puts ans.join("\n")