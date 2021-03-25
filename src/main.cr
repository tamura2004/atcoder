a,b,x = gets.to_s.split.map(&.to_i64)

case
when a.zero?
  puts b // x + 1
else
  puts (b // x) - ((a - 1) // x)
end
