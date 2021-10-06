h, w, d = gets.to_s.split.map(&.to_i)
a = Array.new(h) { gets.to_s.split.map(&.to_i64.- 1) }

pos = Array.new(h*w, {-1, -1})
h.times do |y|
  w.times do |x|
    v = a[y][x]
    pos[v] = {y, x}
  end
end

dp = Array.new(h*w, 0_i64)
(h*w).times do |i|
  next if i - d < 0
  y, x = pos[i]
  ny, nx = pos[i-d]
  cost = (y-ny).abs + (x-nx).abs
  dp[i] = dp[i-d] + cost
end

q = gets.to_s.to_i
q.times do
  l, r = gets.to_s.split.map(&.to_i64.- 1)
  ans = dp[r] - dp[l]
  pp ans
end


