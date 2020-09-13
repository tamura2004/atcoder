struct Complex(T)
  getter real : T
  getter imag : T

  def initialize(@real : T, @imag : T = T.zero)
  end

  def abs2
    real * real + imag * imag
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
