def fft(a)
  n = a.size
  return a if n == 1
  w = Complex.polar(1, -2 * Math::PI / n)
  a1 = fft((0..n / 2 - 1).map { |i| a[i] + a[i + n / 2] })
  a2 = fft((0..n / 2 - 1).map { |i| (a[i] - a[i + n / 2]) * (w ** i) })
  a1.zip(a2).flatten
end

def ifft(a)
  fft(a.map(&:conj)).map(&:conj).map { _1.real / a.size }
end

def conv(a, b)
  a1 = fft(a)
  b1 = fft(b)
  c = a1.zip(b1).map { _1 * _2 }.to_a
  fft(c.map(&:conj)).map(&:conj).map { _1.real / a.size }.map(&:round)
end

x = [1, 1, 1, 1, 0, 0, 0, 0]
y = [1, 1, 1, 1, 0, 0, 0, 0]
pp conv(x, y)
