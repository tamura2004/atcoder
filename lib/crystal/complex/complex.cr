require "crystal/rational"

struct Complex(T)
  include Comparable(Complex(T))

  getter real : T
  getter imag : T

  def y
    imag
  end

  def x
    real
  end

  def self.read
    real, imag = gets.to_s.split.map(&.to_i64)
    new(real, imag)
  end

  def self.zero
    Complex(T).new(0, 0)
  end

  # 平面幾何で利用する場合を想定した辞書順ソート
  def <=>(other : self)
    ret = real <=> other.real
    ret != 0 ? ret : imag <=> other.imag
  end

  def zero?
    real.zero? && imag.zero?
  end

  def initialize(real, imag = T.zero)
    @real = T.new(real)
    @imag = T.new(imag)
  end

  def abs2
    real * real + imag * imag
  end

  def abs
    Math.sqrt(abs2)
  end

  def conj
    Complex(T).new(real, -imag)
  end

  def +(b : self)
    Complex(T).new(real + b.real, imag + b.imag)
  end

  {% for op in %w(+ -) %}
    def {{op.id}}(b : Int)
      Complex(T).new(real {{op.id}} b, imag)
    end
  {% end %}

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

  def chebi
    Math.max real.abs, imag.abs
  end

  # 偏角ソート用、有理数角度
  def phase
    area = (real < 0).to_unsafe
    {area, R.new(imag, real)}
  end

  def to_r
    R.new(real,imag)
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

  def to_s
    "#{real}+#{imag}i"
  end
end

alias C = Complex(Int64)

struct Int
  def i
    C.new(0_i64, to_i64)
  end

  def y
    C.new(0_i64, to_i64)
  end

  def x
    C.new(to_i64, 0_i64)
  end

  def +(b : C)
    C.new(b.real + to_i64, b.imag)
  end
end
