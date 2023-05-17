require "crystal/mod_int"
require "crystal/segment_tree"

s = gets.to_s
n = s.size

# 部分列DP
# 配るDPで書く
# iは1-indexed、先頭にi=0の空文字があると想定
# dp[i文字目を残した場合] := 通り数
# 初期値
# dp[0] := 1
# 遷移
# c <- 'a'..'z'
# dp[post[i][c]] += dp[i]
# post[i][c]は、1-indexedのi文字目以降で
# cが出現する位置（自身を含まない）
# ex
#   0 1 2 3 4 5
#   _ a b c c a
# a 1 5 5 5 5 6
# b 2 2 6 6 6 6
# c 3 3 3 4 6 6
#
# dp
#   0 1 2 3 4 5
#   1 1 1 2 1 4

post = Array.new(n+1){Hash(Char,Int32).new(n+1)}
(0...n).reverse_each do |i|
  post[i+1].each do |k,v|
    post[i][k] = v
  end
  post[i][s[i]] = i + 1
end

dp = Array.new(n+1, 0.to_m)
dp[0] = 1.to_m

n.times do |i|
  ('a'..'z').each do |c|
    j = post[i][c]
    next if n < j
    j = post[j][c] if i + 1 == j && i != 0
    next if n < j
    dp[j] += dp[i]
  end
end

pp dp.sum.-(1).to_m




