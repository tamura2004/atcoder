# 小さい方からK番目
# クエリの個数がK以上の最小値

n, m, k = gets.to_s.split.map(&.to_i64)
lcm = n.lcm(m)

query = -> (x : Int64) do
  x // n + x // m - (x // lcm) * 2 >= k
end

lo = 0_i64
hi = Int64::MAX
ans = (lo..hi).bsearch(&query)
pp ans
