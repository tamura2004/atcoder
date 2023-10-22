require "crystal/modint9"
require "crystal/fact_table"

n,m,a,b = gets.to_s.split.map(&.to_i64)

if a <= n && b < m
  puts (n+m).c(n) - (a+b).c(a) * (n+m-a-b).c(n-a)
else
  puts (n+m).c(n)
end