# いわゆるコンプガチャの期待値
# n種類、等しい確率のコンプガチャの期待値は
# n * (1 + 1/2 + 1/3 + ... + 1/n)

n = gets.to_s.to_i64
ans = (1..n).sum do |i|
  n / i
end

pp ans
