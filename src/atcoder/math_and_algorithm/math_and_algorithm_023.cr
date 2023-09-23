# 期待値の線形性
# 確率変数 X, Y と期待値に関して以下が成立する
# E[X + Y] = E[X] + E[Y]
# より一般的に E[Σ i=1..n, Xi] = Σ i=1..n, E[Xi]
# これはX, Yが独立でなくとも成立する

n = gets.to_s.to_i64
ans = (1..n).sum do
  p, q = gets.to_s.split.map(&.to_i64)
  q / p
end
pp ans
