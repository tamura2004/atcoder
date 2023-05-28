# dp[i文字目][j caps off: 0 , on: 1]

INF = Int64::MAX//4

x,y,z = gets.to_s.split.map(&.to_i64)
s = gets.to_s
n = s.size
dp = make_array(INF, n+1, 2)
dp[0][0] = 0_i64
dp[0][1] = z

n.times do |i|
  2.times do |j|
    2.times do |jj|

      cnt = 0_i64
      if jj == 1 && s[i] == 'a'
        cnt = y 
      elsif jj == 0 && s[i] == 'A'
        cnt = y
      else
        cnt = x
      end

      cnt += z if j != jj
      chmin dp[i+1][jj], dp[i][j] + cnt
    end
  end
end

pp dp[-1].min