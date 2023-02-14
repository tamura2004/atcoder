n = gets.to_s.to_i
a = gets.to_s.split.map(&.to_i)
m = gets.to_s.to_i
b = gets.to_s.split.map(&.to_i).to_set
x = gets.to_s.to_i

dp = Array.new(x+1, false)
dp[0] = true

(0...x).each do |i|
  next if !dp[i]
  a.each do |j|
    jj = i + j
    next if jj.in?(b)
    next if x < jj
    dp[i+j] = true
  end
end

puts dp[-1] ? :Yes : :No
