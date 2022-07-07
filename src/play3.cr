# しゃくとり法で開始位置ごとの答えを求めておく
# 移動先はダブリング

n, q, x = gets.to_s.split.map(&.to_i64)
w = gets.to_s.split.map(&.to_i64)
wsum = w.sum
ww = w + w

cnt = Array.new(n, 0_i64)
nex = Array.new(60) { Array.new(n, -1_i64) }

# しゃくとり法
m, r = x.divmod(wsum)
hi = 0_i64
sum = 0_i64
n.times do |lo|
  while hi < lo || (sum < r && hi < n * 2)
    sum += ww[hi]
    hi += 1
  end

  cnt[lo] = m * n + hi - lo
  nex[0][lo] = hi % n

  sum -= ww[lo]
end

# ダブリング準備
(1...60).each do |i|
  n.times do |j|
    nex[i][j] = nex[i-1][nex[i-1][j]]
  end
end

q.times do
  k = gets.to_s.to_i64.pred
  j = 0_i64

  60.times do |i|
    next if k.bit(i) == 0
    j = nex[i][j]
  end

  ans = cnt[j]
  pp ans
end
