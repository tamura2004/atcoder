# スライド最小

require "crystal/st"

n, k = gets.to_s.split.map(&.to_i)
a = gets.to_s.split.map(&.to_i.pred)

ix = Array.new(n, -1_i64)
n.times do |i|
  ix[a[i]] = i.to_i64
end

lo = n.to_st_min
hi = n.to_st_max

ans = Int32::MAX
n.times do |i|
  j = ix[i]
  lo[j] = j
  hi[j] = j

  if i >= k - 1
    cnt = hi[0..] - lo[0..]
    chmin ans, cnt
    jj = ix[i-k+1]
    lo[jj] = Int64::MAX
    hi[jj] = Int64::MIN
  end
end

pp ans