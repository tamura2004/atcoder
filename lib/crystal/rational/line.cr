require "crystal/rational"

# 有理数を使った直線の一意表現
# crystalのStructはそのままHashのキーにできる
struct Line
  getter slope : Rational     # 傾き
  getter intercept : Rational # y切片

  def initialize(x1 : Int, y1 : Int, x2 : Int, y2 : Int)
    case
    when x1 == x2
      @slope = Rational.new(1,0)
      @intercept = Rational.new(x1,1)
    when y1 == y2
      @slope = Rational.new(0,1)
      @intercept = Rational.new(y1,1)
    else
      @slope = Rational.new(y2 - y1, x2 - x1)
      @intercept = Rational.new(
        (x2 - x1) * y1 - (y2 - y1) * x1,
        x2 - x1
      )
    end
  end

  def initialize(z : C, w : C)
    initialize(z.real, z.imag, w.real, w.imag)
  end
end