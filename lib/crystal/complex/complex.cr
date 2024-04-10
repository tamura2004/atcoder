struct Complex(T)
  include Comparable(Complex(T))

  getter real : T
  getter imag : T

  def ===(v : Int)
    real === v && imag.zero?
  end

  def y : T
    imag
  end

  def x : T
    real
  end

  def x=(v : T)
    @real = v
  end

  def y=(v : T)
    @imag = v
  end

  def flip
    self.class.new(imag, real)
  end

  def self.read
    real, imag = gets.to_s.split.map { |v| T.new(v.to_i64) }
    new(real, imag)
  end

  def self.zero
    Complex(T).new(0, 0)
  end

  def self.unit(e = 1)
    Complex(T).new(e, e)
  end

  # 極座標から生成
  def self.from_poler(phase, r)
    new(
      r * Math.cos(phase),
      r * Math.sin(phase),
    )
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
    typeof(self).new(real, -imag)
  end

  def +(b : self)
    typeof(self).new(real + b.real, imag + b.imag)
  end

  {% for op in %w(+ -) %}
    def {{op.id}}(b : Int)
      typeof(self).new(real {{op.id}} b, imag)
    end
  {% end %}

  def -(b : self)
    typeof(self).new(real - b.real, imag - b.imag)
  end

  def *(b : self)
    typeof(self).new(
      real * b.real - imag * b.imag,
      real * b.imag + imag * b.real
    )
  end

  def *(i : Int)
    typeof(self).new(
      real * i,
      imag * i
    )
  end

  def //(i : Int)
    typeof(self).new(
      real // i,
      imag // i
    )
  end

  def /(i)
    typeof(self).new(
      real / i,
      imag/i
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

  def chebyshev
    Math.max real.abs, imag.abs
  end

  # 原点となす長方形の面積
  def rect
    cross(y.y)
  end

  # 偏角ソート用、有理数角度
  def phase
    area = (real < 0).to_unsafe
    {area, R.new(imag, real)}
  end

  def includes?(b : self)
    b.y < y && b.x < x
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
    "#{x}.x+#{y}.y"
  end

  def to_s(io)
    io << inspect
  end

  def pred
    x.pred.x + y.pred.y
  end

  def pred_x
    x.pred.x + y.y
  end

  def pred_y
    x.x + y.pred.y
  end

  def succ
    x.succ.x + y.succ.y
  end

  def succ_x
    x.succ.x + y.y
  end

  def succ_y
    x.x + y.succ.y
  end

  def transpose
    x.y + y.x
  end

  def times(&block : self ->) : Nil
    x.times do |xx|
      y.times do |yy|
        yield xx.x + yy.y
      end
    end
  end

  def times
    TimesIterator(typeof(self)).new(self)
  end

  private class TimesIterator(T)
    include Iterator(T)

    @n : T
    @index : T

    def initialize(@n : T, @index = T.zero)
    end

    def next
      if @index.y < @n.y && @index.x < @n.x
        value = @index
        @index.x += 1
        if @n.x <= @index.x
          @index.x = 0
          @index.y += 1
        end
        value
      else
        stop
      end
    end
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

  def to_c
    C.new(to_i64, 0_i64)
  end

  def +(b : C)
    C.new(b.real + to_i64, b.imag)
  end

  def ===(b : C)
    self === b.real && b.imag.zero?
  end
end

class Array
  def to_c
    C.new self[0].not_nil!, self[1].not_nil!
  end
end
