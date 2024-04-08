ans = gets.to_s.chars.zip(0..).group_by(&.[0]).select { |k, v| v.size == 1 }.values.first.first.last
pp ans + 1