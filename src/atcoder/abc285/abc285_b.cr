n = gets.to_s.to_i
s = gets.to_s

(1...n).each do |i|
  ans = 0
  n.times do |j|
    break if n <= i + j
    break if s[j] == s[i+j]
    ans += 1
  end
  pp ans
end
