dp = Array.new(101, true)

2.upto(100) do |i|
  i.step(by: i, to: 100) do |j|
    dp[j] = !dp[j]
  end
end

1.upto(100) do |i|
  pp i if dp[i]
end
