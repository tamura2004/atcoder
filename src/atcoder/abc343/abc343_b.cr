n = gets.to_s.to_i64
n.times do
  puts gets.to_s.split.map(&.to_i).zip(1..).select(&.[0].== 1).map(&.last).join(" ")
end
