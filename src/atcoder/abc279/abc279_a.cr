s = gets.to_s.chars.tally
ans = 0_i64
if s.has_key?('v')
  ans += s['v']
end

if s.has_key?('w')
  ans += s['w'] * 2
end

pp ans
