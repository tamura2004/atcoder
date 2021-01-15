# bitDPで部分集合を列挙
#
# ```
# s = 0b101
# each_subset(s) do |ss|
#   printf("%03b\n",b)
# end
#
# # => 101
# # => 100
# # => 001
#
# ```
def each_subset(s)
  b = s
  while b > 0
    yield b
    b -= 1
    b &= s
  end
end

# グラフが十分に小さいので
# 隣接リストの代わりにbitを用いる
# すると、クリーク判定がbit演算でできる
n,m = gets.to_s.split.map { |v| v.to_i }
g = Array.new(n, 0)
m.times do
  i,j = gets.to_s.split.map { |v| v.to_i - 1 }
  g[i] |= 1<<j
  g[j] |= 1<<i
end

# 頂点の部分集合sについて、クリーク判定
clique = Array.new(1<<n) do |s|
  n.times.all? do |i|
    s.bit(i) == 0 || (g[i] | (1<<i)) & s == s
  end
end

# dp[s] := sが未確定のときのクリーク数
# dp[s/t] = max dp[s] + 1 if t.clique? && t != {}
# dp[s/t] = max dp[s] if !t.clique?
dp = Array.new(1<<n, Int32::MAX)
dp[-1] = 0

((1<<n)-1).downto(1) do |s|
  each_subset(s) do |b|
    if clique[b]
      dp[s & ~b] = Math.min dp[s & ~b], dp[s] + 1
    end
  end
end

pp dp[0]
