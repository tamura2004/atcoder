n,s,t = gets.to_s.split.map(&.to_i64)
w = gets.to_s.to_i64

ans = (s..t).includes?(w) ? 1 : 0
(2..n).each do
  a = gets.to_s.to_i64
  w += a
  ans += 1 if (s..t).includes?(w)
end

pp ans