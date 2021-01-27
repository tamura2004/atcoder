# https://atcoder.jp/contests/dp/tasks/dp_e
macro chmin(a, b)
  {{a}} = ({{b}}) if ({{a}}) > ({{b}})
end

# dp[価値] := 重さの最小値
# dp[0] = 0
# dp[x != 0] = INF
# chmin dp[i], dp[i - v[i]] + w[i]

n, m = gets.to_s.split.map { |v| v.to_i64 }
w, v = Array.new(n) { gets.to_s.split.map { |v| v.to_i64 } }.transpose

vmax = v.sum
dp = Array.new(vmax + 1, Int64::MAX)
dp[0] = 0i64
n.times do |i|
  vmax.downto(v[i]) do |j|
    next if dp[j - v[i]] == Int64::MAX
    # pp [j, j - v[i]]
    chmin dp[j], dp[j - v[i]] + w[i]
  end
end

pp dp.zip(0..).select(&.first.<= m).last.last