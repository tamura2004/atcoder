n = gets.to_s.to_i
ans = Deque.new "abc".chars.map(&.to_s)

while ans.size > 0
  s = ans.shift
  if s.size == n
    puts s
    next
  end
  "abc".chars.each do |c|
    ans << s + c
  end
end

