# dp[i] = 文字Tのi文字目まで一致させるのにかかるコスト

INF = Int64::MAX//4

t = gets.to_s
m = t.size
dp = Array.new(m+1, INF)
dp[0] = 0_i64

n = gets.to_s.to_i
n.times do |i|
  ss = gets.to_s.split[1..]
  tmp = dp.dup
  (1..m).each do |j|
    next if dp[j-1] == INF
    ss.each do |s|
      k = s.size
      tt = t[j-1..j+k-2]
      if tt == s
        chmin tmp[j+k-1], dp[j-1] + 1
      end
    end
  end
  dp = tmp
end

pp dp[-1] == INF ? -1 : dp[-1]



