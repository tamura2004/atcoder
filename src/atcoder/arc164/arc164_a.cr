t = gets.to_s.to_i
t.times do
  n, k = gets.to_s.split.map(&.to_i64)
  x = n.to_s(3).chars.sum(&.to_i64)
  if x <= k <= n && ((n - k).even? || (x - k).even?)
    puts :Yes
  else
    puts :No
  end
end