# 区間が広義単調減少であるとき、部分区間についても成り立つ
# ゆえに、尺取り法が使用できる

n = gets.to_s.to_i64
a = gets.to_s.split.map(&.to_i64)

hi = 0
ans = 0

n.times do |lo|
  while hi < lo || (hi < n - 1 && a[hi] >= a[hi+1])
    hi += 1
  end

  chmax ans, hi - lo
end

pp ans

