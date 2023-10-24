n, m = gets.to_s.split.map(&.to_i64)
pins = Array.new(m, false)

n.times do |j|
  a, b = gets.to_s.split.map(&.to_i)
  pin = j - a - b
  next unless (0...m).includes?(pin)
  pins[pin] = true
end

ans = pins.count(&.itself)
pp ans