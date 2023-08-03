require "crystal/graph"

s = gets.to_s.split.map(&.to_i64)
ans = s.all? { |v| 100 <= v <= 675 && v.divisible_by? 25 } &&
      (0...7).all? { |i| s[i] <= s[i + 1] }
puts ans ? :Yes : :No
