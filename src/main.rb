def fft(x)
  n = x.size
  return if n == 1

  x0 = Array.new(n/2) { |i| x[2*i] }
  x1 = Array.new(n/2) { |i| x[2*i + 1] }

  fft(x0)
  fft(x1)

  real = Math.cos(2 * Math::PI / n.to_f)
  imag = Math.sin(2 * Math::PI / n.to_f)
  zeta = Complex(real, imag)
  pow_zeta = Complex(1.0, 0.0)

  n.times do |i|
    x[i] = x0[i % (n/2)] + pow_zeta * x1[i % (n/2)]
    pow_zeta *= zeta
  end
end

def ifft(x)
  n = x.size
  n.times do |i|
    x[i] = x[i].conj
  end

  fft(x)

  n.times do |i|
    x[i] = x[i].conj / Complex(n.to_f, 0.0)
  end
end

class Problem
  attr_accessor :n,:a,:b,:n2

  def initialize
    @n = gets.to_i
    @n2 = 1
    while @n2 < 2 * n + 1
      @n2 <<= 1
    end
    @a = Array.new(n2, Complex(0.0,0.0))
    @b = Array.new(n2, Complex(0.0,0.0))
    n.times do |i|
      ar, br = gets.to_s.split.map { |v| v.to_f }
      a[i+1] = Complex(ar, 0.0)
      b[i+1] = Complex(br, 0.0)
    end
  end

  def solve
    fft(a)
    fft(b)
    f = a.zip(b).map { |(i, j)| i*j }
    ifft(f)
    f
  end

  def show(ans)
    1.upto(2*n) do |i|
      puts (ans[i].real + 0.5).to_i
    end
  end
end

Problem.new.instance_eval do
  show(solve)
end