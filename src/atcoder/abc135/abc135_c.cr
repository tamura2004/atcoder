# 3 5 2
# |/|/
# 4 5

n = gets.to_s.to_i64
a = gets.to_s.split.map(&.to_i64)
b = gets.to_s.split.map(&.to_i64)

a = Deque.new(a)
b = Deque.new(b)

ans = 0_i64
while b.size > 0
  x = a.shift
  y = b.shift

  if x >= y
    ans += y
  else
    ans += x
    y -= x

    if a[0] < y
      ans += a[0]
      a[0] = 0_i64
    else
      ans += y
      a[0] -= y
    end
  end
end

pp ans