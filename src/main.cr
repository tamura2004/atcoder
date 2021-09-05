n = gets.to_s.to_i
a = gets.to_s.split.map(&.to_i)
pp a.zip(1..).sort(&.first)