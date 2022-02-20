require "crystal/fact_table"

n,x,y,z = gets.to_s.split.map(&.to_i64.abs)
m = x + y + z
d = n - m

if d < 0 || d.odd?
  pp 0
  exit
end

a1 = n.c(x)
a2 = (n-x).c(y)
a3 = (n-x-y).c(z)
if d == 0
  ans = a1 * a2 * a3
  pp ans
else
  ans = a1 * a2 * a3 * 6.to_m ** (d//2) * d.c(d//2)
  pp ans
end

# pp! 3.c(2)
# pp! (m-x).c(0)
# pp! m
# pp! 10.c(0)