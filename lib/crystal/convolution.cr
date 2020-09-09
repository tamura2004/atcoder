require "complex"

def fft(x : Array(Complex))
  n = x.size
  return if n == 1

  x0 = Array.new(n//2) { |i| x[2*i] }
  x1 = Array.new(n//2) { |i| x[2*i + 1] }

  fft(x0)
  fft(x1)

  real = Math.cos(2 * Math::PI / n.to_f64)
  imag = Math.sin(2 * Math::PI / n.to_f64)
  zeta = Complex.new(real, imag)
  pow_zeta = Complex.new(1.0, 0.0)

  n.times do |i|
    x[i] = x0[i % (n//2)] + pow_zeta * x1[i % (n//2)]
    pow_zeta *= zeta
  end

  return x
end

def ifft(x : Array(Complex))
  n = x.size
  n.times do |i|
    x[i] = x[i].conj
  end

  fft(x)

  n.times do |i|
    x[i] = x[i].conj / Complex.new(n.to_f64, 0.0)
  end

  return x
end

def to_complex(n, a)
  b = Array(Complex).new(n, Complex.zero)
  a.each_with_index do |v, i|
    b[i+1] = Complex.new(v.to_f64, 0.0_f64)
  end
  return b
end

# Calculate fft convolution
#
# ```
# a = [1,2,3].map(&.to_i64)
# b = [2,4,6].map(&.to_i64)
# pp convolution(a,b) # => [0, 0, 2, 8, 20, 24, 18, 0]
# ```
def convolution(a : Array(Int64), b : Array(Int64))
  return [] of Int64 if a.empty? || b.empty?
  n = [a.size, b.size].max
  n2 = 1
  while n2 < n * 2 + 1
    n2 <<= 1
  end
  c = to_complex(n2, a)
  d = to_complex(n2, b)
  fft(c)
  fft(d)
  f = c.zip(d).map { |(i, j)| i*j }
  ifft(f)
  f.map { |i| (i.real + 0.5).to_i64 }
end
