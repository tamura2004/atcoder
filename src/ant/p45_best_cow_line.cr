n = gets.to_s.to_i
s = gets.to_s.chars
t = s.reverse


ans = [] of Char
while s.size > 0
  if s < t
    ans << s.shift
    t.pop
  else
    ans << t.shift
    s.pop
  end
end

puts ans.join