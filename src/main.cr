require "crystal/indexable"

n,k = gets.to_s.split.map(&.to_i64)
m = n * 3 + 1

dp = Array.new(4){ Array.new(m, 0_i64) }
dp[0][0] = 1_i64

3.times do |i|
  cs = dp[i].cs
  m.times do |j|
    dp[i+1][j] = cs.range_sum(j-n...j)
  end
end

# tot = a + b + c
cs = dp[3].cs[1..]
tot = cs.bsearch_index(&.>= k) || cs.size - 1
k -= cs[tot-1]

# pp dp[3]
# pp dp[2]

cs = dp[2][..tot-1].reverse.cs
a = cs.bsearch_index(&.>= k) || cs.size - 1
k -= cs[a-1]

cs = dp[1][..tot-a-1].reverse.cs
b = cs.bsearch_index(&.>= k) || cs.size - 1

c = tot - a - b
puts "#{a} #{b} #{c}"
