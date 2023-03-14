require "crystal/dynamic_mod_big_int"

a, x, m = gets.to_s.split.map(&.to_i64.to_big_i)
quit x % m if a == 1

ModInt.mod = m * a.pred
pp a.to_m.pow(x).pred.to_big_i // a.pred