n = gets.to_s.to_i
a = gets.to_s.split.map { |v| v.to_i }
pp a.tally.values.map { |v| v * (n - v) }.sum / 2
