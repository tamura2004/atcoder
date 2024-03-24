# dpを行う、dp[i桁まで決めた][i桁は反転している][連続文字の回数0 or 1] := コスト

n = gets.to_s.to_i64
s = gets.to_s.chars.map(&.to_i)
c = gets.to_s.split.map(&.to_i64)

INF = Int64::MAX // 4

dp = make_array(INF, n, 2, 2)
dp[0][0][0] = 0_i64
dp[0][1][0] = c[0]

(1...n).each do |i|
    2.times do |rev|
        pre = rev == 1 ? 1 - s[i-1] : s[i-1]
        2.times do |nrev|
            now = nrev == 1 ? 1 - s[i] : s[i]
            2.times do |seq|
                nseq = pre == now ? 1 : 0
                next if 2 <= seq + nseq
                chmin dp[i][nrev][seq + nseq], dp[i-1][rev][seq] + c[i] * nrev
            end
        end
    end
end

pp dp[-1].map(&.[1]).min

            
