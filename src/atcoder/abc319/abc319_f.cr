# 木DP

require "crystal/graph"

n = gets.to_s.to_i64

p, t, s, ga = Array.new(n - 1) { gets.to_s.split.map(&.to_i64) }.transpose

g = Graph.from_plist(p)

pp g
