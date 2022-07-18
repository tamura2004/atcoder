require "crystal/segment_tree"

n,m = gets.to_s.split.map(&.to_i64)
ab = Array.new(n) do
  Tuple(Int32,Int32).from gets.to_s.split.map(&.to_i.pred)
end

bs = Array.new(m) { [] of Int32 }
dp = m.to_st_sum
ab.each do |a,b|
  dp[a] += 1
  bs[a] << b
end

cnt = (m+1).to_st_sum

hi = 0
m.times do |lo|
  while hi < lo || (hi < m && dp[lo..hi] < n)
    hi += 1
  end

  if hi < m
    cnt[hi-lo] += 1
    cnt[m-lo] -= 1
  end

  bs[lo].each do |b|
    dp[b] += 1
  end
end

ans = [] of Int64
m.times do |i|
  ans << cnt[..i]
end

puts ans.join(" ")