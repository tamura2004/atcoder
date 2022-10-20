n = gets.to_s.to_i
robots = Array.new(n) do
  x, l = gets.to_s.split.map(&.to_i64)
  {x - l, x + l}
end.sort_by(&.last)

ans = 0_i64
right = Int64::MIN
robots.each do |lo, hi|
  next if lo < right
  ans += 1
  right = hi
end

pp ans
