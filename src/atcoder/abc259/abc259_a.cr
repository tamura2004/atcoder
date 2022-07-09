n, m, x, t, d = gets.to_s.split.map(&.to_i64)

if m >= x
  pp t
else
  pp t - (x - m) * d
end
