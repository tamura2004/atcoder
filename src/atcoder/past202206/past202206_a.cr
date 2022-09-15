x, a, b, c = gets.to_s.split.map(&.to_i64)

case x * a <=> x * b + a * b * c
when 0
  puts "Tie"
when 1
  puts "Hare"
when -1
  puts "Tortoise"
end
