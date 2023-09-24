require "crystal/matrix"
require "crystal/static_mod_int"

n = gets.to_s.to_i64
m = Matrix(StaticModInt(1000000000i64)).parse("1 1;1 0")
ans = (m ** n)[0, 1]
pp ans
