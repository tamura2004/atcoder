n, k = gets.to_s.split.map(&.to_i64)
a = gets.to_s.split.map(&.to_i64)

def combi(n, k)
  return 1_i64 if k == 0
  return 0_i64 if n < k
  return 1_i64 if n == k
  return combi(n - 1, k - 1) + combi(n - 1, k)
end

ans = a.sum * combi(n - 1, k - 1)
pp ans