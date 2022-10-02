n = gets.to_s.to_i
a = Deque.new gets.to_s.split.map(&.to_i64).sort
ans = 0_i64

while a[0] > 1
  b = a.pop
  c = b % a[0]
  if c > 0
    a.unshift c
  end
  ans += 1
end

pp ans + a.size - 1



