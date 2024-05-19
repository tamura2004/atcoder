#
# +--------+
# |        |
# |        |
# |\       |
# | \      |
# |  \     |
# |   \    |
# |    \   |
# |     \  |
# |      \ |
# +-------\+-----------

ar = [
  [0, 0, 0, 0, 0],
  [0, 2, 3, 3, 4],
  [0, 3, 6, 7, 8],
].map(&.map(&.to_i64))

a, b, c, d = gets.to_s.split.map(&.to_i64)
if a < 0
  da = divceil(-a, 4) * 4
  a += da
  c += da
end
if b < 0
  db = divceil(-b, 2) * 2
  b += db
  d += db
end
# TODO: y++2, x++2で正の整数になるようにする

# (0, 0) - (x, y)の面積の合計（２倍）
area = -> (x : Int64, y : Int64) do
  ans = 0_i64
  xi = x // 4
  yi = y // 2
  ans += xi * yi * 8

  # pp! ans

  yy = y % 2
  xx = x % 4

  ans += ar[yy][4] * xi + ar[2][xx] * yi + ar[yy][xx]
  # pp! [ans, x, y, xx, yy, xi, yi]
  ans
end

# pp! area.call(3_i64,3_i64)
ans = area.call(c, d) - area.call(a, d) - area.call(c, b) + area.call(a, b)
pp ans
