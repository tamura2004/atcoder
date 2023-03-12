h, w = gets.to_s.split.map(&.to_i)
a = Array.new(h) { gets.to_s.split.map(&.to_i) }

q = Deque(Tuple(Int32, Int32, Array(Int32))).new
q << {0, 0, [a[0][0]]}

ans = 0_i64
while q.size > 0
  y, x, ar = q.shift

  if y == h - 1 && x == w - 1
    ans += 1
    next
  end

  if y < h - 1 && !ar.includes?(a[y + 1][x])
    nar = ar.dup
    nar << a[y + 1][x]
    q << {y + 1, x, nar}
  end

  if x < w - 1 && !ar.includes?(a[y][x + 1])
    nar = ar.dup
    nar << a[y][x + 1]
    q << {y, x + 1, nar}
  end
end

puts ans
