w, h = gets.to_s.split.map(&.to_i64)
if w * 3 == h * 4
  puts "4:3"
else
  puts "16:9"
end
