n, t = gets.to_s.split.map(&.to_i64)
a = gets.to_s.split.map(&.to_i64)

tate = Array.new(n, 0)
yoko = Array.new(n, 0)
naname = 0
gyaku = 0

t.times do |i|
  v = a[i]
  y, x = v.pred.divmod(n)
  tate[x] += 1
  quit i.succ if tate[x] == n
  yoko[y] += 1
  quit i.succ if yoko[y] == n
  if y == x
    naname += 1
    quit i.succ if naname == n
  end
  if y + x == n.pred
    gyaku += 1
    quit i.succ if gyaku == n
  end
end
puts -1