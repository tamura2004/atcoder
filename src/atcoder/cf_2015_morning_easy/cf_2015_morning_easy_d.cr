# 最長共通部分列の長さ
def lcs(a, b)
  # pp! [a.join,b.join]
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
  # pp! dp[-1][-1]
  dp[-1][-1]
end

n = gets.to_s.to_i64
s = gets.to_s.chars

ans = 0_i64
n.times do |i|
  chmax ans, lcs(s[0..i],s[i+1..])
end

pp n - ans * 2