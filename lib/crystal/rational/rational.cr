# 有理数クラス a / b
struct Rational
  include Comparable(self)

  getter a : Int64
  getter b : Int64

  def initialize(a, b) # 分子、分母
    a = a.to_i64
    b = b.to_i64

    case
    when a.zero? && b.zero?
      @a = 0_i64
      @b = 0_i64
    when a.zero?
      @a = 0_i64
      @b = sign(b)
    when b.zero?
      @a = sign(a)
      @b = 0_i64
    else
      if b < 0
        a = -a
        b = -b
      end
      gcd = a.gcd(b)
      @a = a // gcd
      @b = b // gcd
    end
  end

  def <=>(c : self)
    case
    when b.zero? && c.b.zero?
      a <=> c.a
    else
      a * c.b <=> c.a * b
    end
  end

  def mul(x,y)
    y.zero? ? inf(x) : x * y
  end

  def inf(x)
    x < 0 ? Int64::MIN : Int64::MAX
  end

  def sign(x)
    x < 0 ? -1_i64 : 1_i64
  end

  def inspect
    "#{a}/#{b}"
  end
end

alias R = Rational