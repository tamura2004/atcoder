require "complex"

struct Complex
  def self.polar(abs, phase)
    new(Math.cos(phase) * abs, Math.sin(phase) * abs)
  end
end

n = gets.to_s.to_i
a = Array.new(n) do
  x,y = gets.to_s.split.map { |v| v.to_f64 }
  Complex.new(x,y)
end
b = Array.new(n) do
  x,y = gets.to_s.split.map { |v| v.to_f64 }
  Complex.new(x,y)
end

f = -> (z : Complex) {
  scale = 0.5_f64
  phase = (b[1] - b[0]).phase - (a[1] - a[0]).phase
  return (z - a[0]) * Complex.polar(scale, phase) + b[0]
}

z = a[0]
10000.times do
  z = f.call(z)
end

puts "#{z.real} #{z.imag}"