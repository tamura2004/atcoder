a,b,c = gets.to_s.split.map(&.to_i64)

x = b - a
y = c - b

if x == y
  puts 0
elsif x < y
  z = (y - x) // 2
  z += 1 if (y-x).odd?
  puts z
else
  puts x - y
end