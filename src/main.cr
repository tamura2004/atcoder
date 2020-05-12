S   = read_line.chomp.chars.map(&.to_i)
N   = S.size
D   = read_line.to_i64
MOD = 10**9 + 7

dp = Array.new(N + 1) { Array.new(2) { Array.new(D, 0) } }
dp[0][0][0] = 1

N.times do |i|
  2.times do |smaller|
    D.times do |mod|
      10.times do |d|
        next if smaller != 1 && S[i] < d
        next_smaller = smaller | (d < S[i] ? 1 : 0)
        next_mod = (mod + d) % D
        
        dp[i + 1][next_smaller][next_mod] += dp[i][smaller][mod]
        dp[i + 1][next_smaller][next_mod] %= MOD
      end
    end
  end
end

puts (dp[N][0][0] + dp[N][1][0] - 1) % MOD # 0を除く
