n = gets.to_s.to_i64
a = gets.to_s.split.map(&.to_i64).sort

b = a.each_cons_pair.map do |i, j|
    j - i
end.to_a.sort

pp b