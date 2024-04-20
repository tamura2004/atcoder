require "crystal/bitset"

n, q = gets.to_s.split.map(&.to_i64)
a = gets.to_s.split.map(&.to_i64.pred)

cnt = Array.new(n, 1_i64)
a.each do |i|
  cnt[i] ^= 1_i64
end

ans = cnt.sum
pp ans
