require "crystal/mod_int"
require "crystal/fact_table"
n = gets.to_s.to_i64
k = gets.to_s.to_i64
ans = n.h(k)
pp ans