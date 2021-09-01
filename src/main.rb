h, w = gets.to_s.split.map { |v| v.to_i }
ab = Array.new(h) { gets.to_s.split.map { |v| v.to_i - 1 } }

# 今どこにいる？
dp = Array.new(w, &:itself)

h.times do |y|
  ans = -1
  a, b = ab[y]
  w.times do |x|
    if a <= dp[x] && dp[x] <= b
      dp[x] = b + 1
    end

    next if dp[x] == w
    cnt = dp[x] - x + y + 1
    ans = cnt if ans == -1 || ans > cnt
  end
  pp ans
end
