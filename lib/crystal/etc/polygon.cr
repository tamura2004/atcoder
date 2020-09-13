struct Complex(T)
  getter real : T
  getter imag : T

  def initialize(@real : T, @imag : T = T.zero)
  end

  def abs2
    real * real + imag * imag
  end

  def abs
    Math.sqrt(abs2)
  end

  def conj
    Complex(T).new(real,-imag)
  end

  def +(b : Complex(T))
    Complex(T).new(real + b.real, imag + b.imag)
  end

  def -(b : Complex(T))
    Complex(T).new(real - b.real, imag - b.imag)
  end
  
  def *(b : Complex(T))
    Complex(T).new(
      real * b.real - imag * b.imag,
      real * b.imag + imag * b.real
    )
  end

  def dot(b : Complex(T))
    (conj * b).real
  end

  def cross(b : Complex(T))
    (conj * b).imag
  end
end

struct Poligon(T)
  getter n : Int32
  getter vs : Array(Complex(T))

  def initialize(@vs : Array(Complex(T)))
    @n = vs.size
  end

  def center
    x = vs.map(&.real).sum / n
    y = vs.map(&.imag).sum / n
    Complex(T).new(x,y)
  end

  def size
    c = center
    total = vs.sum do |v|
      (v - c).abs
    end
    total / n
  end
end

# n = gets.to_s.to_i
# va = Array.new(n){ 
#   x,y = gets.to_s.split.map { |v| v.to_f64 }
#   Complex(Float64).new(x,y)
# }
# a = Poligon(Float64).new(va)
# vb = Array.new(n){ 
#   x,y = gets.to_s.split.map { |v| v.to_f64 }
#   Complex(Float64).new(x,y)
# }
# b = Poligon(Float64).new(vb)

# puts b.size / a.size
