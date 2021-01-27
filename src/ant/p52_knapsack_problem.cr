macro chmax(target, other)
  {{target}} = ({{other}}) if ({{target}}) < ({{other}})
end

alias Pair = Tuple(Int64, Int64)

n,wmax = gets.to_s.split.map { |v| v.to_i }
v,w = Array.new(n){ gets.to_s.split.map { |v| v.to_i64 } }.transpose

# dp[重さ] := 価値
# dp[j] = dp[j - w[i]] + v[i]
# ただしjは大きい順,
dp = Array.new(wmax+1, 0_i64)
n.times do |i|
  wmax.downto(w[i]) do |j|
    chmax dp[j], dp[j - w[i]] + v[i]
  end
end

puts dp[-1]