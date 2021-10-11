require "crystal/abc222/e/path_count"
require "crystal/abc222/e/knapsack"
include Abc222::E
include EdgeLabeledTree

n, m, k = gets.to_s.split.map(&.to_i)
a = gets.to_s.split.map(&.to_i.- 1)

g = Tree.new(n)
(n - 1).times do |i|
  v, nv = gets.to_s.split.map(&.to_i64)
  g.add v, nv, i
end

st = PathCount.new(g)
a.each_cons_pair do |v, nv|
  st.solve(v, nv)
end

cnt = st.dp

# r + b = sum
# r - b = k
# 2r = sum + k
tot = cnt.sum + k
if (cnt.sum + k).odd?
  puts 0
  exit
end

dp = Knapsack.new(st.dp).solve
pp dp[tot//2]
