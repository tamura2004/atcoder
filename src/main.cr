h,w = gets.to_s.split.map(&.to_i64)

case
when h == 1
  pp w
when w == 1
  pp h
else
  h = (h + 1) // 2
  w = (w + 1) // 2
  ans = h * w
  pp ans
end
