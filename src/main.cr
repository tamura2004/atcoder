require "crystal/weighted_tree/rerooting"
include WeightedTree

n = gets.to_s.to_i64
g = Tree.new(n)
(n - 1).times do
  v, nv, cost = gets.to_s.split.map(&.to_i64)
  g.add v, nv, cost
end
d = gets.to_s.split.map(&.to_i64)

alias A = Int64
alias V = Int32
alias F1 = Proc(A, V, A, A)
alias F2 = Proc(A, V, A)
alias M = Proc(A, A, A)

rr = Rerooting(Int64).new(
  g,
  F1.new { |a, v, cost| Math.max(a, d[v]) + cost },
  M.new { |a, b| Math.max a, b },
  0_i64,
  F2.new { |a, v| a }
)

ans = rr.solve
puts ans.join("\n")

pp g.g