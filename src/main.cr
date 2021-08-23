require "crystal/digit_dp"

def solve2(s)
  a = s.to_i
  ans = 0_i64
  1.upto(a) do |i|
    ans += i.to_s.count('0')
  end
  ans
end

def solve(s)
  a = s.chars.map(&.to_i)
  n = a.size
  dd = DigitDP.new(a)
  dp = make_array(0_i64, n + 1, 2, 2, n + 1)
  dp[0][0][0][0] = 1_i64
  dd.each_with_leading_zero do |i,j,k,d,jj,kk|
    n.times do |c|
      cc = c
      cc += 1 if d == 0 && c < n
      next if jj == ZERO
      dp[i+1][jj][kk][cc] += dp[i][j][k][c]
    end
  end
  dp
end

pp solve2("100")
pp solve("100")
