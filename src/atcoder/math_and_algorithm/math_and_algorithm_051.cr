require "crystal/mod_int"
require "crystal/matrix"
require "crystal/fact_table"

m = "2 -1;-1 2".to_mat
x, y = gets.to_s.split.map(&.to_i64)

xx, yy = m * [x, y]

if xx.divisible_by?(3) && yy.divisible_by?(3)
  pp (xx//3 + yy//3).c(xx//3)
else
  pp 0
end
