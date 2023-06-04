n = gets.to_s.to_i64
case
when n < 1000
  puts n
when n < 10000
  puts n // 10 * 10
when n < 100000
  puts n // 100 * 100
when n < 1000000
  puts n // 1000 * 1000
when n < 10000000
  puts n // 10000 * 10000
when n < 100000000
  puts n // 100000 * 100000
else
  puts n // 1000000 * 1000000
end
