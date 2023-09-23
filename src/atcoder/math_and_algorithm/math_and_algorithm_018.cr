require "crystal/tally"

n = gets.to_s.to_i64
a = gets.to_s.split.map(&.to_i64).tally
ans = [100, 200].sum do |i|
  a[i] * a[500 - i]
end

pp ans
