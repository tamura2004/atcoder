require "crystal/mod_int"

n, k = gets.to_s.split.map(&.to_i64)

case
when n == 1
  puts k
when n == 2
  puts k.to_m * (k - 1)
when k <= 2
  puts 0
else
  puts (k.to_m - 2)**(n - 2)*(k - 1)*k
end
