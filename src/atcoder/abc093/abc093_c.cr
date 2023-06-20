a = gets.to_s.split.map(&.to_i64).sort
b = a.map(&.-(a[0]))

ans = 0_i64

case
when b[1].odd? && b[2].odd?
  b[1] += 1
  b[2] += 1
  ans += 1
when b[1].odd? && b[2].even?
  b[1] -= 1
  ans += 1
when b[1].even? && b[2].odd?
  b[2] -= 1
  ans += 1
when b[1].even? && b[2].even?
end

ans += (b[2] * 2 - b[1]) // 2
pp ans