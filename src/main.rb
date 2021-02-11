s = gets.chomp
case s[2, 1]
when "B"
  puts "Bachelor #{s[0, 2]}"
when "M"
  puts "Master #{s[0, 2]}"
when "D"
  puts "Doctor #{s[0, 2]}"
end
