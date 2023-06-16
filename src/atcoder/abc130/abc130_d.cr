require "crystal/segment_tree"

n, k = gets.to_s.split.map(&.to_i64)
a = gets.to_s.split.map(&.to_i64)
st = a.to_st_sum

ans = 0_i64
hi = 0_i64
n.times do |lo|
  while st[lo..hi] < k && hi < n
    hi += 1
  end

  ans += n - hi
end

pp ans
