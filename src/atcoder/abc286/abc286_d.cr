# 個数制限付きナップサック
n, x = gets.to_s.split.map(&.to_i64)
dp = make_array(false, n + 1, x + 1)
dp[0][0] = true

n.times do |i|
  a, b = gets.to_s.split.map(&.to_i64)
  (0i64..b).each do |cnt|
    (0i64..x).each do |yen|
      yyen = yen + cnt * a
      break if x < yyen
      dp[i + 1][yyen] ||= dp[i][yen]
    end
  end
end

puts dp[-1][-1] ? :Yes : :No
