n = gets.to_s.to_i64
a = gets.to_s.split.map(&.to_i64)

(n-1).times do |i|
  s, t = gets.to_s.split.map(&.to_i64)
  a[i+1] += a[i] // s * t
end

pp a[-1]