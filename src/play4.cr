n, a = gets.to_s.split.map(&.to_i64)
x = gets.to_s.split.map(&.to_i64.- a)

N = 5000_i64
dp = Array.new(N, 0_i64)
OFFSET = N // 2
dp[OFFSET] = 1_i64

x.each do |v|
  wk = dp.dup
  N.times do |i|
    j = v + i
    next unless 0 <= j < N
    dp[j] += wk[i]
  end
end

pp dp[OFFSET] - 1
