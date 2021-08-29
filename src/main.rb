def range_sum(a, b)
  (a + b) * (b - a + 1) / 2
end

ans = 0
ans += range_sum(81, 100)
ans += range_sum(51, 80) * 2
# ans += 50 * 4
# ans += 49

pp ans
