s = gets.to_s
t = gets.to_s
n = t.size

left = Array.new(n + 1, true)
right = Array.new(n + 1, true)

n.times do |i|
  left[i + 1] = left[i] && (s[i] == '?' || t[i] == '?' || s[i] == t[i])
end

t = t.reverse
s = s.reverse

n.times do |i|
  right[i + 1] = right[i] && (s[i] == '?' || t[i] == '?' || s[i] == t[i])
end

right.reverse!

(0..n).each do |i|
  puts left[i] && right[i] ? "Yes" : "No"
end
