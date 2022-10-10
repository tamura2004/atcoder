require "crystal/matrix"

s = gets.to_s.chars
t = gets.to_s.chars
u = gets.to_s.to_i

dp = Array.new(u + 1) do
  Matrix(Int64).zero(s.size + 1, t.size + 1)
end

s.size.times do |i|
  t.size.times do |j|
    (0..u).each do |k|
      if s[i] == t[j]
        chmax dp[k][i + 1, j + 1], dp[k][i, j] + 1
      else
        chmax dp[k][i + 1, j + 1], Math.max(dp[k][i + 1, j], dp[k][i, j + 1])
        kk = k + 1
        next if u < kk
        chmax dp[kk][i + 1, j + 1], dp[k][i, j] + 1
      end
    end
  end
end

pp dp[-1][-1, -1]
