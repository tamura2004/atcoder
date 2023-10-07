s = gets.to_s
n = s.size // 2
ans = true
n.times do |i|
  if s[i*2 + 1] == '1'
    ans = false
  end
end
puts ans ? "Yes" : "No"
