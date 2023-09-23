require "crystal/tally"
n = gets.to_s.to_i64
a = gets.to_s.split.map(&.to_i64).tally.values
ans = a.sum { |x| x * (x - 1) // 2 }
pp ans
