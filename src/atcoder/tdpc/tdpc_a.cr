require "crystal/bitset"
n = gets.to_s.to_i64
a = gets.to_s.split.map(&.to_i64)
dp = [0].to_bitset(10000)
a.each(&->dp.shift_or!(Int64))
pp dp.popcount
