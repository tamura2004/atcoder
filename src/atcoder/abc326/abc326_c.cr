n, m = gets.to_s.split.map(&.to_i64)
a = gets.to_s.split.map(&.to_i64).sort

hi = 0
ans = 0_i64

n.times do |lo|
  while hi < n && a[hi] - a[lo] < m
    hi += 1
  end
  chmax ans, hi - lo
end

pp ans