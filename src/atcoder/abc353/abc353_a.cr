n = gets.to_s.to_i64
h = gets.to_s.split.map(&.to_i64)

ans = -1
n.times do |i|
  if h[0] < h[i] && ans == -1
    ans = i + 1
  end
end

pp ans