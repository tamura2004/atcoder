def f(s)
  n = s.size
  return false if n.odd?
  (n//2).times.all? do |i|
    (s[i] == 'p' && s[n-i-1] == 'q') ||
    (s[i] == 'q' && s[n-i-1] == 'p') ||
    (s[i] == 'b' && s[n-i-1] == 'd') ||
    (s[i] == 'd' && s[n-i-1] == 'b')
  end
end

s = gets.to_s
puts f(s) ? "Yes" : "No"