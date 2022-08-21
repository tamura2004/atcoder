a, b = gets.to_s.split.map(&.to_i64)
if a <= 8 && b <= 8
  puts "Yay!"
else
  puts ":("
end