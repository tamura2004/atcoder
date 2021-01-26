macro chmax(target, other)
  {{target}} = ({{other}}) if ({{target}}) < ({{other}})
end

n,m = gets.to_s.split.map { |v| v.to_i }
w,v = Array.new(n){ gets.to_s.split.map { |v| v.to_i64 } }.transpose

dp = Array.new(m+1, 0_i64)
n.times do |i|
  (m-w[i]+1).times do |j|
    chmax dp[j + w[i]], dp[j] + v[i]
  end
end

pp dp[-1]