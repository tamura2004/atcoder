n = gets.to_s.to_i
a = gets.to_s.split.map(&.to_i.pred)

same = a.zip(0..).count { |i, j| i == j }.to_i64
ans = same * (same - 1) // 2

other = 0_i64
n.times do |i|
  next if a[i] == i
  if a[a[i]] == i
    other += 1
  end
end

ans += other // 2
pp ans
