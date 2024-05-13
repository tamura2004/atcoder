n = gets.to_s.to_i64
f = Array.new(n) do
  gets.to_s.split.map(&.to_i64).join.to_i(2)
end
p = Array.new(n) do
  gets.to_s.split.map(&.to_i64)
end

ans = (1<<10).times.max_of do |s|
  next -Int64::MAX if s.zero?
  n.times.sum do |i|
    cnt = (s & f[i]).popcount
    p[i][cnt]
  end
end

pp ans
