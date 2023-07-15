n = gets.to_s.to_i64
ans = Set(String).new
uniq = Set(String).new

n.times do
  s = gets.to_s
  rs = s.reverse
  if s == rs
    uniq << s
  else
    ans << s
    ans << s.reverse
  end
end

pp ans.size // 2 + uniq.size
