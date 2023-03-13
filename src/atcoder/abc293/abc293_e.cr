require "crystal/dynamic_mod_int"
require "crystal/matrix"

a, x, m = gets.to_s.split.map(&.to_i128)
quit x % m if a == 1

ModInt.mod = m * a.pred
pp a.to_m.pow(x).pred // a.pred 