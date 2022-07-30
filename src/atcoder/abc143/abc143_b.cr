require "crystal/modint9"
require "crystal/fact_table"

n = gets.to_s.to_i64

cnt = (n*n).times.sum do |i|
  i.c(n-1) * (n*n-1-i).c(n-1) * (n-1).f * (n-1).f
end

ans = (n*n).f - cnt * (n*n) * ((n-1)**2).f
# pp! (n*n).f
# pp! cnt
# pp! (n*n)
# pp! ((n-1)**2).f
pp ans
