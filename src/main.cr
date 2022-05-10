require "crystal/modint9"

n, d = gets.to_s.split.map(&.to_i)
a = gets.to_s.split.map(&.to_i.pred)

dp = make_array(0.to_m, n + 1, 1 << d)
dp[0][0] = 1.to_m

(1 << n).times do |s|
  n.times do |i|
    if a[i] == -2
      if s.even?
        dp[i+1][s >> 1] += dp[i][s]
      else
        (1..d*2).each do |j|
          next if s.bit(j) == 1
          dp[i + 1][(s | (1 << j))>>1] += dp[i][s]
        end
      end
    else
      if s.even?
        next if a[i] - d
      j = a[i]
      if s.bit(j) == 0
        dp[i + 1][s | (1 << j)] += dp[i][s]
      end
    end
  end
end

pp dp[-1][-1]
