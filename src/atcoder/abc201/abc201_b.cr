n = gets.to_s.to_i
st = Array.new(n) do
  s, t = gets.to_s.split
  t = t.to_i64
  {t, s}
end.sort
ans = st[-2][1]
puts ans