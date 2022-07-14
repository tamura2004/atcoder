a, b = gets.to_s.split.map(&.to_i)
puts a + 1 == b || (a == 1 && b == 10) ? :Yes : :No
