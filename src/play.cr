def lcs(a, b)
  h = a.size
  w = b.size

  dp = make_array(0_i64, h + 1, w + 1)
  h.times do |y|
    w.times do |x|
      if a[y] == b[x]
        dp[y + 1][x + 1] = dp[y][x] + 1
      else
        dp[y + 1][x + 1] = Math.max dp[y][x + 1], dp[y + 1][x]
      end
    end
  end
  dp[-1][-1]
end
