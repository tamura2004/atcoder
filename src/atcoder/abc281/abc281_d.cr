# dp[i番目][j個取る][m == mod d] := 最大値
n, k, d = gets.to_s.split.map(&.to_i64)
a = gets.to_s.split.map(&.to_i64)
dp = make_array(-1_i64, n + 1, k + 1, d)
dp[0][0][0] = 0_i64

enum Use
  No
  Yes
end

n.times do |i|
  (0..k).each do |j|
    (0...d).each do |m|
      next if dp[i][j][m] == -1

      Use.each do |use|
        next if use.yes? && j == k

        ii = i + 1
        jj = j + use.yes?.to_unsafe
        mm = m
        mm += a[i] if use.yes?
        mm %= d if use.yes?

        nex = dp[i][j][m]
        nex += a[i] if use.yes?
        chmax dp[ii][jj][mm], nex
      end
    end
  end
end

pp dp[-1][-1][0]
