# 桁DP dp[i桁目][桁和][余り][未満] := 個数
# 桁和　1..126
# 余り 0..125

EDGE = 0
FREE = 1

nn = gets.to_s.to_i64
a = nn.to_s.chars.map(&.to_i)
n = a.size
maxi = n * 9
ans = 0_i64

(1..maxi).each do |sum|
  dp = make_array(0_i64, a.size + 1, maxi+1, maxi+1, 2)
  dp[0][0][0][EDGE] = 1_i64


  a.size.times do |i|
    maxi.times do |m|
      maxi.times do |s|
        [EDGE, FREE].each do |k|
          next if i.zero? && k == FREE
          10.times do |d|
            next if k == EDGE && a[i] < d
            kk = k == EDGE && d == a[i] ? EDGE : FREE
            ss = s + d
            next if maxi < ss
            mm = (m * 10 + d) % sum
            dp[i+1][ss][mm][kk] += dp[i][s][m][k]
            # pp dp[i+1][ss][mm][kk] if dp[i][s][m][k] > 0
           end
        end
      end
    end
  end
  ans += dp[-1][sum][0].sum
end

pp ans



