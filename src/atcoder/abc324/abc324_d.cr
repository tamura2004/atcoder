n = gets.to_s.to_i64
a = gets.to_s.chars.sort.join
hi = Math.isqrt(10_i64 ** n)

cnt = Hash(String,Int64).new(0_i64)
(0_i64..hi).each do |i|
  key = sprintf("%0#{n}d", i ** 2).chars.sort.join
  cnt[key] += 1
end

ans = cnt[a]
pp ans
