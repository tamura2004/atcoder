# 有理数クラス a / b
# structなのでキーになる
struct Rational
  getter a : Int64 # 分子(常に0以上)
  getter b : Int64 # 分母
  def_equals_and_hash a, b

  def initialize(a, b)
    a, b = {a, b}.map(&.to_i64)
    a, b = {a, b}.map(&.-) if a < 0

    case
    when a.zero? && b.zero?
      @a = 0_i64
      @b = 0_i64
    when a.zero?
      @a = 0_i64
      @b = 1_i64
    when b.zero?
      @a = 1_i64
      @b = 0_i64
    else
      gcd = a.gcd(b)
      @a = a // gcd
      @b = b // gcd
    end
  end

  def +(t : self)
    R.new(t.b*a + b*t.a, t.b * b)
  end

  def inv
    R.new(b, a)
  end

  def -
    R.new(a, -b)
  end

  def rot90
    -inv
  end

  def zero?
    a.zero? && b.zero?
  end

  def self.zero
    R.new(0, 0)
  end

  def inspect
    "#{a}/#{b}"
  end
end

alias R = Rational

class String
  def to_r
    a, b = split(/\//).map(&.to_i64)
    R.new(a,b)
  end
end

struct Complex
  def to_r
    R.new(real, imag)
  end
end