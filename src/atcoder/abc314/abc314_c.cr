# n, m = gets.to_s.split.map(&.to_i)
# s = gets.to_s.chars
# c = gets.to_s.split.map(&.to_i.pred)

# ans = Array(Char?).new(n, nil.as(Char?))
# dp = Array.new(m, nil.as(Char?))

# n.times do |i|
#   if ch = dp[c[i]]
#     ans[i] = ch
#   end
#   dp[c[i]] = s[i]
# end

# n.times do |i|
#   next unless ans[i].nil?
#   ans[i] = dp[c[i]]
# end

# puts ans.join

n, m = gets.to_s.split.map(&.to_i)
s = gets.to_s
c = gets.to_s.split.map(&.to_i.pred)

cnt = Array.new(m) { [] of Int32 }
n.times do |i|
  cnt[c[i]] << i
end

ans = Array.new(m) do |i|
  cnt[i].rotate.zip cnt[i]
end.flatten.sort.map(&.last).map { |i| s[i] }.join

puts ans
