require "big"

n,a,b,c = gets.to_s.split.map(&.to_i64)
aa = gets.to_s.split.map(&.to_i64)

ab = a.lcm(b)
ac = a.lcm(c)
bc = b.lcm(c)
abc = a.lcm(b).lcm(c)

dp = Array.new(n+1) do
  Array.new(1<<3) do
    Int64::MAX
  end
end

dp[0][0] = 0_i64

n.times do |i|
  (1<<3).times do |j|
    next if dp[i][j] == Int64::MAX
    # 何もしない
    chmin dp[i+1][j], dp[i][j]
    # aの倍数になるまでインクリメント
    chmin dp[i+1][j|1], dp[i][j] + (aa[i] % a == 0 ? 0 : a - aa[i] % a)
    # bの倍数になるまでインクリメント
    chmin dp[i+1][j|2], dp[i][j] + (aa[i] % b == 0 ? 0 : b - aa[i] % b)
    # cの倍数になるまでインクリメント
    chmin dp[i+1][j|4], dp[i][j] + (aa[i] % c == 0 ? 0 : c - aa[i] % c)
    # abの倍数になるまでインクリメント
    chmin dp[i+1][j|3], dp[i][j] + (aa[i] % ab == 0 ? 0 : ab - aa[i] % ab)
    # acの倍数になるまでインクリメント
    chmin dp[i+1][j|5], dp[i][j] + (aa[i] % ac == 0 ? 0 : ac - aa[i] % ac)
    # bcの倍数になるまでインクリメント
    chmin dp[i+1][j|6], dp[i][j] + (aa[i] % bc == 0 ? 0 : bc - aa[i] % bc)
    # abcの倍数になるまでインクリメント
    chmin dp[i+1][j|7], dp[i][j] + (aa[i] % abc == 0 ? 0 : abc - aa[i] % abc)
  end
end

puts dp[n][7]