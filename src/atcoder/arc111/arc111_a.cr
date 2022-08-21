require "crystal/number_theory/modpow"

n, m = gets.to_s.split.map(&.to_i64)
ans = modpow(10, n, m ** 2) // m
pp ans