x,y,z = gets.to_s.split.map(&.to_i64)

if x < 0
  x = -x
  y = -y
  z = -z
end

if 0 < y < x
  if y < z
    pp -1
  else
    pp z.abs + (x - z).abs
  end
else
  pp x
end