require "crystal/tree/rerooting"
require "crystal/mod_int"

alias T = Tuple(ModInt,Int32)
alias V = Int32

n = gets.to_s.to_i
g = Tree.new(n)
(n-1).times do
  v, nv = gets.to_s.split.map(&.to_i64)
  g.add v, nv
end

rr = Rerooting(T).new(
  tree: g,
  merge: -> (a : T, b : T) {
    ai, aj = a
    bi, bj = b

    T.new(
      ai * bi * (aj + bj).c(aj),
      aj + bj
    )
  },
  apply: -> (a : T, v : V) {
    ai, aj = a
    T.new(ai, aj + 1)
  },
  unit: { 1.to_m, 0 }
)
ans = rr.solve
puts ans.map(&.first).join("\n")

# pp rr