def _fft(a)
  n = a.size
  return a if n == 1
  w = Complex.polar(1, -2 * Math::PI / n)
  a1 = fft((0..n / 2 - 1).map { |i| a[i] + a[i + n / 2] })
  a2 = fft((0..n / 2 - 1).map { |i| (a[i] - a[i + n / 2]) * (w ** i) })
  a1.zip(a2).flatten
end

def fft(a)
  n = a.size
  _fft(a).map { _1 / Complex(n, 0) }
end

def ifft(a)
  _fft(a.map { _1.conj }).map { _1.conj }
end

x = [1, 2, 3, 4]
y = [5, 6, 7, 8]
pp ifft(fft(x).zip(fft(y)).map { |i, j| i * j })
