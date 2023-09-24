require "crystal/mod_int"
require "crystal/fact_table"
x, y = gets.to_s.split.map(&.to_i64)
pp (x + y).c(x)
