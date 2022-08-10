require "crystal/fft"

n = gets.to_s.to_i64
a = gets.to_s.split.map(&.to_i64)

x = Array.new(200_000, 0_i64)
y = Array.new(200_000, 0_i64)

a.each do |v|
  x[v - 1] += 1
  y[200_000 - v] += 1
end

pp conv(x, y).count(&.> 0)