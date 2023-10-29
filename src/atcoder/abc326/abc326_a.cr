x, y = gets.to_s.split.map(&.to_i64)
ans = x - 3 <= y <= x + 2
puts ans ? :Yes : :No