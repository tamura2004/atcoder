require "crystal/dynamic_mod_int"
require "crystal/matrix"

a, x, m = gets.to_s.split.map(&.to_i64)
ModInt.mod = m

mt = Matrix(ModInt).new([
  [a.to_m, 1.to_m],
  [0.to_m, 1.to_m]
])

mt = mt ** (x - 1)
pp mt.rows[0].sum