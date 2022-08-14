require "crystal/fenwick_tree"

s = gets.to_s
t = s.tr("atcoder","1234567").chars.map(&.to_i)
ans = inversion_number(t)
pp ans