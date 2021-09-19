a, b, c = gets.to_s.split.map(&.to_i64)
a, c = c, a unless a <= b

ans = 0_i64
if c - a < (b - a) * 2 # up
  if (c - a).odd?
    c += 1
    ans += 1
  end
  ans += b - (c - a) // 2
else # down
  if (c - a).odd?
    c -= 1
    ans += 1
  end
  ans += (c - a) // 2 - b
end

pp ans