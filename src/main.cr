n = gets.to_s.to_i
ans = Array.new(n) { Array.new(n, '.') }

x1 = y1 = 0
x2 = y2 = n - 2

while n > 0
  box(y1,y2,x1,x2,ans)
  x1 += 2
  y2 -= 4
  x2 -= 2
  n -= 4
end

puts ans.map(&.join).join("\n")

def box(y1, y2, x1, x2, ans)
  vline(y1, y2, x1, ans)
  hline(y2, x1, x2, ans)
  vline(y1, y2 - 2, x2, ans)
  hline(y2 - 2, x1 + 2, x2, ans)
end

def vline(y1, y2, x, ans)
  return unless 0 <= y1
  return unless 0 <= y2
  return unless 0 <= x
  return unless y1 <= y2
  (y1..y2).each do |y|
    ans[y][x] = '#'
  end
end

def hline(y, x1, x2, ans)
  return unless 0 <= y
  return unless 0 <= x1
  return unless 0 <= x2
  return unless x1 <= x2
  (x1..x2).each do |x|
    ans[y][x] = '#'
  end
end
