$n = gets.to_i
$dp = Array.new($n+10, -1)

def rec(x)
  return $dp[x] = 0 if $n <= x
  return $dp[x] if $dp[x] != -1
  return $dp[x] = 6.times.map{|i| rec(x+i+1) + 1}.sum / 6.0
end

pp rec(0)