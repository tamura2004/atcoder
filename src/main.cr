n,k = gets.to_s.split.map(&.to_i64)
dp = Array.new(n+1, 0_i64)

m = Math.sqrt(n).to_i
2.upto(n) do |i|
  next if dp[i] != 0
  i.step(by: i, to: n) do |j|
    dp[j] += 1
  end
end

pp dp.count(&.>= k)

