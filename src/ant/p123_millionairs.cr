m = gets.to_s.to_i
p = gets.to_s.to_f
x = gets.to_s.to_i
n = 1 << m

dp = Array.new(2) { Array.new((1 << m) + 1, 0.0) }
prv = dp[0]
nxt = dp[1]
prv[n] = 1.0

m.times do |r|
  0.upto(n) do |i|
    jub = Math.min i, n - i
    nxt[i] = 0.upto(jub).max_of do |j|
      p * prv[i + j] + (1 - p) * prv[i - j]
    end
  end
  prv, nxt = nxt, prv
end

i = x * n // 1000000
puts prv[i]
