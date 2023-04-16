require "crystal/indexable"
n = gets.to_s.to_i64
ans = gets.to_s.split.map(&.to_i64).tally.values.map(&.// 2).sum
pp ans