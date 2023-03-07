# 1/1000単位
require "complex"

h,w,d = gets.to_s.split.map(&.to_f64)
dd = d ** 2
STEP = 10_000_000
dh = h / 2.0 / STEP

ans = 0_f64
STEP.times do |i|
  break if d < dh * i
  ans += dh * Math.min(w / 2, Math.sqrt(dd - (dh * i) ** 2))
end

pp ans * 4 / (h * w)
