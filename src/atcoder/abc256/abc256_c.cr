# 9マスに制約に沿って自然数を入れる
# 分かりやすさ優先で、1文字変数割り当て
#
#     w1 w2 w3
#    +--+--+--+
# h1 |a |b |c |
#    +--+--+--+
# h2 |d |e |f |
#    +--+--+--+
# h3 |g |i |j |
#    +--+--+--+
#
# 左上4マスa,b,d,eを全探索
# 28 ** 4 == 614656なので間に合う

h1, h2, h3, w1, w2, w3 = gets.to_s.split.map(&.to_i64)
ans = 0_i64

(1..28).to_a.each_repeated_permutation(4) do |(a, b, d, e)|
  c = h1 - a - b
  f = h2 - d - e
  g = w1 - a - d
  i = w2 - b - e
  j1 = w3 - c - f
  j2 = h3 - g - i

  next unless 1 <= c <= 28
  next unless 1 <= f <= 28
  next unless 1 <= g <= 28
  next unless 1 <= i <= 28
  next unless 1 <= j1 <= 28
  next unless 1 <= j2 <= 28
  next unless j1 == j2

  ans += 1
end

pp ans
