enum State
  Free # 何を置いても良い
  Edge # ギリギリ
  Empt # まだ何も置いてない
end
# 遷移なし
# | Empt && 先頭である && d > a[i]
# | Edge && d > a[i]
# Empt
# | 置かない(d == 0) := Empt
# | 先頭である && a[i] == d := Edge 
# Edge
# | a[i] == d := Edge 
# それ以外 := Free

a, kmax = gets.to_s.split.map(&.to_i64)
a = a.to_s.chars.map(&.to_i)

n = a.size
dp = Array.new(n+1) do
  Hash(State,Hash(Int64,Int64)).new do |h,k|
    h[k] = Hash(Int64,Int64).new(0_i64)
  end
end
inf = Int64::MAX//10
dp[0][State::Empt][1_i64] = 1_i64

n.times do |i|
  State.each do |j|
    dp[i][j].keys.each do |k|
      10.times do |d|
        next if j.empt? && i.zero? && a[i] < d
        next if j.edge? && a[i] < d

        jj = State::Free
        jj = State::Edge if i.zero? && j.empt? && d == a[i]
        jj = State::Edge if j.edge? && d == a[i]
        jj = State::Empt if j.empt? && d.zero?

        kk = k * d
        kk = inf if kmax < kk
        kk = k if j.empt? && d.zero?

        dp[i+1][jj][kk] += dp[i][j][k]
      end
    end
  end
end

ans = dp[-1].values.sum(&.select(&.< inf).values.sum).pred
pp ans
