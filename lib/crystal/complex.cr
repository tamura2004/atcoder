struct Complex(T)
  include Comparable(Complex(T))

  getter real : T
  getter imag : T

  # 平面幾何で利用する場合を想定した辞書順ソート
  def <=>(b : self)
    ret = real <=> b.real
    ret != 0 ? ret : imag <=> b.imag
  end

  def zero?
    real.zero? && imag.zero?
  end

  def initialize(real : T, imag : T = T.zero)
    @real = T.new(real)
    @imag = T.new(imag)
  end

  def abs2
    real * real + imag * imag
  end

  def conj
    Complex(T).new(real, -imag)
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

  def *(i : Int)
    Complex(T).new(
      real * i,
      imag * i
    )
  end

  def //(i : Int)
    Complex(T).new(
      real // i,
      imag // i
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

  def deg
    Math.atan2(imag, real) * 180.0_f64 / Math::PI
  end

  # 垂直二等分線
  # ax + by + c = 0
  def vertial_bisector(nv : self)
    a = (self - nv).real
    b = (self - nv).imag
    c = nv.abs2 - abs2

    g = a.gcd(b).gcd(c)

    a //= g
    b //= g
    c //= g

    if a < 0 || (a == 0 && b < 0) || (b == 0 && c < 0)
      a *= -1
      b *= -1
      c *= -1
    end

    {a, b, c}
  end

  def inspect
    "#{real}+#{imag}i"
  end
end

alias C = Complex(Int64)
