# 区間dp
# dp[i][j] := 囚人i,jを両端に含む区画を開放する時に支払う金額
# dp[i][i] = 0
# dp[i][i+1] = 0
# dp[i][j] = min a[j] - a[i] - 2 + dp[i][k] + dp[k][j] | i < k < j

macro chmin(target, other)
  {{target}} = ({{other}}) if ({{target}}) > ({{other}})
end

n,m = gets.to_s.split.map { |v| v.to_i }
a = gets.to_s.split.map { |v| v.to_i }
a = [0] + a + [n+1]
n = a.size

INF = Int32::MAX
dp = Array.new(n){ Array.new(n, INF) }
n.times do |i|
  dp[i][i] = 0
  dp[i-1][i] = 0 if i != 0
end

2.upto(n) do |w|
  n.times do |i|
    j = i + w
    next if n <= j

    dp[i][j] = (i+1).upto(j-1).min_of do |k|
      a[j] - a[i] - 2 + dp[i][k] + dp[k][j]
    end
  end
end

pp dp[0][-1]
