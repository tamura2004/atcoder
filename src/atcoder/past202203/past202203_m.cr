require "crystal/multiset"

n, q = gets.to_s.split.map(&.to_i64)
a = gets.to_s.split.map(&.to_i64)
ix = a.zip(0i64..).to_h
dp = a.to_multiset

q.times do
  cmd, x, y = gets.to_s.split.map(&.to_i64) + [0_i64]
  case cmd
  when 1
    x -= 1
    dp.delete(a[x])
    dp << y
    a[x] = y
    ix[y] = x
  when 2
    x -= 1
    ans = dp.count_upper(a[x], eq: true)
    pp ans
  when 3
    if po = dp[n - x]
      pp ix[po] + 1
    end
  end
end