s = Time.parse_local(gets.to_s, "%Y-%m-%d")
t = Time.parse_local(gets.to_s, "%Y-%m-%d")
ans = 0_i64

loop do
  ans += 1 if s.sunday? || s.saturday?
  break if s == t
  s += 1.day
end

pp ans
