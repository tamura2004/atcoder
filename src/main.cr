require "crystal/graph"
require "crystal/graph/rerooting"

alias T = Int64
alias V = Int32
alias E = Int32
alias F1 = Proc(T, V, E, T)
alias MG = Proc(T, T, T)
alias F2 = Proc(T, V, T)

n = gets.to_s.to_i
g = Graph.new(n)
(n - 1).times do
  g.read
end

f1 = F1.new { |a, i, j| a }
merge = ->(a : Int64, b : Int64) { a + b }
unit = 0_i64
f2 = ->(a : Int64, i : Int32) { a + 1 }

rr = Rerooting(Int64).new(g, f1, merge, unit, f2)
rr.solve
dp = rr.dp

cnt = Array.new(n - 1, 1_i64)
g.each do |v|
  g.edges(v).each_with_index do |(nv, _, i), j|
    cnt[i] *= dp[v][j]
  end
end

pp cnt.sum
