n,k = gets.to_s.split.map(&.to_i)
a = Array.new(n){gets.to_s.to_i64}

quit n if a.any?(&.zero?)

hi = 0
acc = 1_i64
ans = 0

n.times do |lo|
  while hi < n && acc * a[hi] <= k
    acc *= a[hi]
    hi += 1
  end

  chmax ans, hi - lo

  if lo < hi
    acc //= a[lo]
  else
    hi += 1
  end
end

pp ans
