require "complex"

# a = x^2 + 2x + 3
# b = 4x^2 + 5x + 6
# ab = 4x^4 + 13x^3 + 28x^2 + 27x + 18

n = 5
a = [1,2,3,0,0,0,0,0]
b = [4,5,6,0,0,0,0,0]

def dft(a)
  n = a.size
  return a if n == 1
  w = Complex.polar(1,-2*Math::PI/n)
  n.times.map do |k|
    n.times.sum do |j|
      a[j]*(w**(j*k))
    end
  end
end

def idft(a)
  n = a.size
  w = Complex.polar(1,-2*Math::PI/n)
  n.times.map do |k|
    n.times.sum do |j|
      a[j]*(w**(-j*k)) / n
    end
  end
end

def fft(a)
  n = a.size
  return a if n == 1
  a1 = a.s
  w = Complex.polar(1,-2*Math::PI/n)
  (n/2).times.map { |k|
    (n/2).times.sum { |j|
      a[2*j]*(w**(2*j*k))
    } +
    (w**k) * (n/2).times.sum { |j|
      a[2*j+1]*(w**(2*j*k))
    }
  } +
  (n/2).times.map { |k|
    (n/2).times.sum { |j|
      a[2*j]*(w**(2*j*k))
    } -
    (w**k) * (n/2).times.sum { |j|
      a[2*j+1]*(w**(2*j*k))
    }
  }
end

c = dft(a).zip(dft(b)).map{|i,j|i*j}
pp dft([1,1]).map(&:real).map(&:round)
# pp idft(c).map(&:real).map(&:round)
    
  