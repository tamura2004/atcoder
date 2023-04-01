a,b,c,d = gets.to_s.split.map(&.to_i64)
case (a * d <=> b * c) * (b * d).sign
when -1
  puts "<"
when 0
  puts "="
when 1
  puts ">"
end
