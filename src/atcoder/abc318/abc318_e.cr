# 同じ数の前回の出現位置
# 同じ数の出現個数
# 同じ数のans

n = gets.to_s.to_i
a = gets.to_s.split.map(&.to_i.pred)

pre = Array.new(n, nil.as(Int32?))
now = Array.new(n, nil.as(Int32?))
cnt = Array.new(n, 0_i64)
dp = Array.new(n, 0_i64)
ans = Array.new(n, 0_i64)

n.times do |i|
  if j = now[a[i]]
    pre[i] = j
  end
  now[a[i]] = i
end

n.times do |i|
  if j = pre[i]
    dp[i] = dp[j] + cnt[j] * (i - j - 1)
    cnt[i] = cnt[j] + 1
    chmax ans[a[i]], dp[i]
  else
    cnt[i] = 1_i64
    dp[i] = 0_i64
  end
end

pp dp.sum
