# dp[i番目][j表裏][s合計] := bool

n, s = gets.to_s.split.map(&.to_i64)
ab = Array.new(n) do
  gets.to_s.split.map(&.to_i64)
end

dp = make_array(false, n + 1, 2, s + 1)
dp[0][0][0] = true
dp[0][1][0] = true

n.times do |i|
  2.times do |j|
    2.times do |jj|
      (0..s).each do |k|
        kk = k + ab[i][jj]
        next if s < kk
        dp[i+1][jj][kk] ||= dp[i][j][k]
      end
    end
  end
end

ans = [] of Char
if dp[-1][0][-1] || dp[-1][1][-1]
  puts "Yes"

  j = dp[-1][0][-1] ? 0 : 1
  i = n
  k = s

  while i > 0
    ans << (j == 1 ? 'T' : 'H')
    i -= 1
    k -= ab[i][j]
    j = dp[i][0][k] ? 0 : 1
  end

  puts ans.reverse.join
else
  puts "No"
end

# pp dp