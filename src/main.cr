require "crystal/modint9"

n,a,b,k = gets.to_s.split.map(&.to_i64)

ans = 0.to_m
(0..n).each do |x|
  next if k < a * x
  next if (k - a * x) % b != 0

  y = (k - a * x) // b

  ans += n.c(x) * n.c(y)
end

pp ans