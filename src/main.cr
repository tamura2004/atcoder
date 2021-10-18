require "crystal/tree/rerooting"

alias A = Int64
alias V = Int32
alias F = Proc(A,V,A)
alias M = Proc(A,A,A)

n,m = gets.to_s.split.map(&.to_i64)
g = Tree.new(n)
(n-1).times do
  v, nv = gets.to_s.split.map(&.to_i64)
  g.add v, nv
end

ans = Rerooting(Int64).new(
  g,
  F.new { |a, v| (a + 1) % m },
  M.new { |a, b| ((a % m) * b) % m },
  1_i64,
  F.new { |a,v| a % m }
).solve

puts ans.join("\n")