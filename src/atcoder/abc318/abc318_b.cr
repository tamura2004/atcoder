n = gets.to_s.to_i
recs = Array.new(n) do
  a, b, c, d = gets.to_s.split.map(&.to_i)
  {a, b, c, d}
end

ans = 0
100.times do |y|
  100.times do |x|
    cnt = n.times.any? do |i|
      a, b, c, d = recs[i]
      a <= x && x + 1 <= b && c <= y && y + 1 <= d
    end
    ans += 1 if cnt
  end
end

pp ans
