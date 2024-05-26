n = gets.to_s.to_i64
a = gets.to_s.split.map(&.to_i64).sort.last > 0
yesno a
