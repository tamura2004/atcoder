# 作用素
# x <- Xに対して、作用（apply）
# chmax x, mini
# chmin x, maxi
# x += incr
# かつ、合成(compose)ができる
class A
  getter mini : Int32
  getter maxi : Int32
  getter incr : Int32

  def initialize(@mini, @maxi, @incr)
  end

  def compose(b : self)
    
  end

  def apply(x)
    chmax x, mini
    chmin x, maxi
    x + incr
  end
end

