# 有理数クラス a / b
struct Rational
  getter a : Int64
  getter b : Int64

  def initialize(a, b)
    a = a.to_i64
    b = b.to_i64

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
      if a < 0
        a = -a
        b = -b
      end
      gcd = a.gcd(b)
      @a = a // gcd
      @b = b // gcd
    end
  end
end
