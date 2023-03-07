h,w,q=gets.to_s.split.map(&.to_i64)
a = Array.new(h) do
  gets.to_s.chars
end

flip = false
if w < h
  flip = true
  h, w = w, h
  a = a.transpose
end
a = a.map{|v| Deque.new v }

ans = [] of Char
q.times do
  cmd, p, c = gets.to_s.split
  cmd = cmd.to_i.pred
  p = p.to_i.pred
  c = c[0]

  if flip
    cmd ^= 1
  end

  case cmd
  when 0
    ans << a[p].pop
    a[p].unshift c
  when 1
    ans << a[-1][p]
    (1...h).reverse_each do |y|
      a[y][p] = a[y-1][p]
    end
    a[0][p] = c
  end
end

puts ans.join