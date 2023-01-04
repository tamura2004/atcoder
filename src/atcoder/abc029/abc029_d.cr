# 桁DP
# dp[i決めた][j状態][kは1の数]
enum S
  Free
  Edge
end

a = gets.to_s.chars.map(&.to_i)
n = a.size

dp = Array.new(n+1) do
  Hash(S,Array(Int64)).new(0_i64) do |h,k|
    h[k] = Array.new(n+1, 0_i64)
  end
end
dp[0][S::Edge][0] = 1_i64

n.times do |i|
  S.each do |j|
    (0..n).each do |k|
      10.times do |d|
        next if j.edge? && a[i] < d
        next if j.free? && i.zero?
        jj = S::Free
        jj = S::Edge if j.edge? && a[i] == d
   
        kk = k + (d == 1).to_unsafe
        next if n < kk
        dp[i+1][jj][kk] += dp[i][j][k]
      end
    end
  end
end

pp dp[-1].values.map(&.zip(0..).sum{|i,j|i*j}).sum
