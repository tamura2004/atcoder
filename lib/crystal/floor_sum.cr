# sum floor((a*i+b)/m),i=0 to n-1 by O(log(a+b+n+m))
def floor_sum(n, m, a, b)
  ans = 0_i64

  if a >= m
    ans += (n - 1) * n * (a // m) // 2
    a %= m
  end

  if b >= m
    ans += n * (b // m)
    b %= m
  end

  y_max = (a * n + b) // m
  x_max = y_max * m - b

  return ans if y_max.zero?

  ans += (n - (x_max + a - 1) // a) * y_max
  ans += floor_sum(y_max, a, m, (a - x_max % a) % a)

  ans
end
