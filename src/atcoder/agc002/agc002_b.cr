n, m = gets.to_s.split.map(&.to_i64)
dp = Array.new(n, false)
dp[0] = true
cnt = Array.new(n, 1)

m.times do
  v, nv = gets.to_s.split.map(&.to_i.pred)
  cnt[v] -= 1
  cnt[nv] += 1

  dp[nv] = true if dp[v]
  dp[v] = false if cnt[v].zero?
end

pp dp.count(true)