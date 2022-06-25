require "crystal/mod_int"
require "crystal/fact_table"

n = gets.to_s.to_i64
ans = 10.pow(n) - 9.pow(n) * 2 + 8.pow(n)
pp ans