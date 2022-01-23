a = gets.to_s.chars.map(&.to_i)
n = a.size

dp = make_array(0_i64, n+1, 10, 2)

EDGE = 0
FREE = 1

dp[0][0][EDGE] = 1_i64

n.times do |i|
  2.times do |k|
    next if i.zero? && k == FREE

    10.times do |d|
      next if k == EDGE && a[i] < d

      kk = k == EDGE && a[i] == d ? EDGE : FREE

      10.times do |j|
        next if j == 9 && d == 1
        jj = d == 1 ? j + 1 : j

        dp[i+1][jj][kk] += dp[i][j][k]
      end
    end
  end
end

ans = 0_i64
dp[-1].each_with_index do |(x,y),i|
  ans += x.to_i64 * i
  ans += y.to_i64 * i
end

pp ans
