n, k = gets.to_s.split.map(&.to_i64)
a = gets.to_s.split.map(&.to_i64)

ans = 0
seat = 0
n.times do |i|
  if seat + a[i] <= k
    seat += a[i]
  else
    ans += 1
    seat = a[i]
  end
end

if seat > 0
  ans += 1
end

pp ans