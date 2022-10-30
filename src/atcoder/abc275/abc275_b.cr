n = gets.to_s.to_i
a = gets.to_s.split.map(&.to_i64).zip(0..).sort.last.last.succ
pp a
