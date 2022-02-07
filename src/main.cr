UP = 0
RT = 1
MOD = 100000

w, h = gets.to_s.split.map(&.to_i)
dp = make_array(0_i64, h, w, 2)
dp[1][0][UP] = 1_i64
dp[0][1][RT] = 1_i64

h.times do |y|
  w.times do |x|
    [UP,RT].each do |d|
      case d
      when UP
        if y < h - 1
          dp[y+1][x][UP] += dp[y][x][UP]
          dp[y+1][x][UP] %= MOD
        end

        if x < w - 2
          dp[y][x+2][RT] += dp[y][x][UP]
          dp[y][x+2][RT] %= MOD
        end
      when RT
        if y < h - 2
          dp[y+2][x][UP] += dp[y][x][RT]
          dp[y+2][x][UP] %= MOD
        end

        if x < w - 1
          dp[y][x+1][RT] += dp[y][x][RT]
          dp[y][x+1][RT] %= MOD
        end
      end
    end
  end
end

pp dp