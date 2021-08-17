require "crystal/digit_dp"

macro make_array(value, *dims)
  {% for dim in dims %} Array.new({{dim}}) { {% end %}
    {{ value }}
  {% for dim in dims %} } {% end %}
end

a = gets.to_s.chars.map(&.to_i)
n = a.size

dd = DigitDP.new(a)
dp = make_array(0_i64, n + 1, n + 1, 2)
dp[0][0][0] = 1_i64

dd.each do |i, from, digit, to|
  (0..n).each do |j|
    jj = j
    jj += 1 if digit == 1 && jj < n
    dp[i+1][jj][to] += dp[i][j][from]
  end
end

ans = dp[-1].each_with_index.sum do |pair, i|
  pair.sum * i
end
pp ans
