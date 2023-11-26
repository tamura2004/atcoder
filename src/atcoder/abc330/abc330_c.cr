d = gets.to_s.to_i64
ans = Int64::MAX
dd = Math.isqrt(d)+1

(0_i64..dd).each do |x|
  cnt = d - x ** 2
  y = cnt < 0 ? 0_i64 : Math.isqrt(cnt)
  chmin ans, (x ** 2 + y ** 2 - d).abs
  chmin ans, (x ** 2 + (y+1) ** 2 - d).abs
end

pp ans