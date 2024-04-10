require "crystal/bitset"
n = gets.to_s.to_i64
a = gets.to_s.split.map(&.to_i64)
sum = a.sum
dp = [0].to_bitset(sum)
a.each(&->dp.shift_or!(Int64))
pp dp.to_a.select(&.*(2).>= sum).min
