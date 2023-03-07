# dp[i袋まで決め][j枚銅貨使った] := {金貨、-使った銀貨}の最大

INF = Int64::MAX//4

n, x = gets.to_s.split.map(&.to_i64)
abcs = Array.new(n) { gets.to_s.split.map(&.to_i64) }
dp = make_array({-INF, INF}, n + 1, x + 1)
dp[0][0] = {0_i64, 0_i64}

n.times do |i|
  (0..x).each do |j|
    2.times do |buy|
      if buy == 0
        si, co, go = abcs[i]
        max_go, max_si = dp[i][j]
        jj = j + co
        next if x < jj

        chmax dp[i + 1][jj], {max_go + go, max_si - si}
      else
        chmax dp[i + 1][j], dp[i][j]
      end
    end
  end
end

gs, co = dp[-1].reverse.zip(0..).max
go, sl = gs

puts "#{go} #{10**9 + sl} #{co}"
