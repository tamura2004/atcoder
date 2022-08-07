# dp[i桁][j余り]

require "crystal/mod_int"

s = gets.to_s
n = s.size
dp = make_array(0.to_m, n + 1, 13)
dp[0][0] = 1.to_m

n.times do |i|
  case s[i]
  when '?'
    10.times do |c|
      13.times do |j|
        jj = (j * 10 + c) % 13
        dp[i+1][jj] += dp[i][j]
      end
    end
  else
    c = s[i].to_i
    13.times do |j|
      jj = (j * 10 + c) % 13
      dp[i+1][jj] += dp[i][j]
    end
  end
end

pp dp[-1][5]