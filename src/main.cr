require "crystal/mod_int"
require "crystal/dfa"

m = gets.to_s.to_i
a = gets.to_s.chars.map(&.to_i)
n = a.size

leq = LEQ(ModInt).new(a)

mod = DFA(Int32, Int32, ModInt).new(
  init: 0,
  nex: ->(s : Int32, d : Int32, i : Int32) { (s + d) % m },
  accept: ->(s : Int32) { s == 0 },
  ok: ->(s : Int32) { false },
  ng: ->(s : Int32) { false },
)

ans = (leq + mod).count(n, (0..9).to_a)
pp ans - 1
