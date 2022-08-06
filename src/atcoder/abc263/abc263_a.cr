a = gets.to_s.split.map(&.to_i64).tally
num = a.values.sort

if a.size == 2 && num == [2,3]
  puts "Yes"
else
  puts "No"
end
