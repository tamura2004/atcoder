n, r = gets.to_s.split.map { |v| v.to_i64 }
a = gets.to_s.split.map { |v| v.to_i64 }.sort

lo = mi = hi = 0
ans = 0_i64

while lo < n
  while mi < n - 1 && a[mi + 1] <= a[lo] + r
    mi += 1
  end

  while hi < n - 1 && a[hi + 1] <= a[mi] + r
    hi += 1
  end

  ans += 1
  lo = hi + 1
end

puts ans
