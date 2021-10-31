n, m, q = gets.split.map(&:to_i)
dp = (0..n).map { 1 << _1 }

xy = Array.new(m) { gets.split.map { _1.to_i - 1 } }.sort
xy.each do |x, y|
  dp[y] |= dp[x]
end

ab = Array.new(q) { gets.split.map { _1.to_i - 1 } }
ab.each do
  puts dp[_2][_1] == 1 ? "Yes" : "No"
end
