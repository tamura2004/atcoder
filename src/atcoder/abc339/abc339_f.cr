require "big"

n = gets.to_s.to_i64
s = Array.new(n){gets.to_s}
a = s.map(&.to_big_i)
len = s.map(&.size)
maxi = len.max

cnt = Hash(BigInt, Int64).new(0_i64)
n.times do |i|
  cnt[a[i]] += 1
end

ans = 0_i64
n.times do |i|
  n.times do |j|
    next if maxi < len[i] + len[j] - 1
    ans += cnt[a[i] * a[j]]
  end
end

pp ans