a, b = gets.to_s.split.map(&.to_i)
ans = ![3,6,9].includes?(a) && (b - a) == 1
puts ans ? :Yes : :No