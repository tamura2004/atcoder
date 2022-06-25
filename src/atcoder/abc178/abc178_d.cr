require "crystal/matrix"
require "crystal/mod_int"
require "crystal/fact_table"

s = gets.to_s.to_i64
quit 0 if s < 3

m = Matrix(ModInt).new([
  [1, 1, 0],
  [0, 0, 1],
  [1, 0, 0]
]) ** (s - 1)

ans = m[0,2]
pp ans