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

  def +(b : self)
    Complex(T).new(real + b.real, imag + b.imag)
  end

  def -(b : self)
    Complex(T).new(real - b.real, imag - b.imag)
  end

  def *(b : self)
    Complex(T).new(
      real * b.real - imag * b.imag,
      real * b.imag + imag * b.real
    )
  end

  def dot(b : self)
    (conj * b).real
  end

  def cross(b : self)
    (conj * b).imag
  end

  def manhattan
    real.abs + imag.abs
  end

  def phase
    Math.atan2 imag, real
  end
end
