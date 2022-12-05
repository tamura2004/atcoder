n = gets.to_s.to_i64
s = gets.to_s.split.map(&.to_i64)

ans = [s[0]]
(1...n).each do |i|
  ans << s[i] - s[i-1]
end

puts ans.join(" ")