require "crystal/complex"
n = gets.to_s.to_i
z = Array.new(n) { C.read }

D = 29
# dp[iにいる][jスキップした] := ペナルティ以外の最小値
dp = make_array(1e100.to_f64, n, D)
dp[0][0] = 0_f64

(1...Math.min(n, D)).each do |j|
  dp[j][j - 1] = (z[j] - z[0]).abs
end

(1...n - 1).each do |i|
  (0...Math.min(D, i)).each do |j|
    (i + 1...n).each do |k|
      next unless j + k - i - 1 < D
      chmin dp[k][j + k - i - 1], dp[i][j] + (z[k] - z[i]).abs
    end
  end
end

# pp dp[-1].zip(0..).map { |cost, i| cost + 2.0f64 ** (i - 1) }.min
pp dp[-1].zip(0..).map { |cost, i| i.zero? ? cost : cost + 2.0f64 ** (i - 1) }.min
