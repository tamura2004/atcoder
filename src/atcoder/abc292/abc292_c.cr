require "crystal/prime"

n = gets.to_s.to_i64
cnt = Array.new(n+1, 0_i64)

(1...n).each do |i|
  cnt[i] = i.prime_division.values.map(&.to_i64.succ).product
end

ans = 0_i64
(1...n).each do |i|
  j = n - i
  ans += cnt[i] * cnt[j]
end

pp ans