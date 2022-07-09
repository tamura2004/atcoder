require "crystal/modint9"
require "crystal/fact_table"

n, m, k = gets.to_s.split.map(&.to_i64)
quit m if n == 1
ans = (0..k).sum do |i|
  (n - 1).c(i) * m * (m - 1).pow(n - 1 - i)
end

pp ans
