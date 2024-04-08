n = gets.to_s.to_i64
a = gets.to_s.split.map(&.to_i64.pred)
ix = a.zip(0..).sort.map(&.last)

q = gets.to_s.to_i64
q.times do
  a, b = gets.to_s.split.map(&.to_i64.pred)
  if ix[a] < ix[b]
    pp a.succ
  else
    pp b.succ
  end
end
