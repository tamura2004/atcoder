struct Int
  def log
    LogNum.from(self)
  end

  def f
    LogNum.f(self)
  end

  def p(k : Int)
    LogNum.p(self, k)
  end

  def c(k : Int)
    LogNum.c(self, k)
  end

  def r(k : Int)
    LogNum.r(self, k)
  end
end

record LogNum, v : Float64 do
  def self.from(n : Int)
    new(Math.log(n))
  end

  def self.f(n : Int)
    new(Math.lgamma(n + 1))
  end

  def self.p(n : Int, k : Int)
    f(n) / f(n - k)
  end

  def self.c(n : Int, k : Int)
    p(n, k) / f(k)
  end

  def self.r(n : Int, k : Int)
    c(n + k - 1, k)
  end

  def self.zero
    new(0.0_f64)
  end

  def *(n : Int)
    LogNum.new(v + n.log.v)
  end

  def *(other : Float)
    LogNum.new(v + other)
  end

  def *(other : self)
    LogNum.new(v + other.v)
  end

  def /(n : Int)
    LogNum.new(v - n.log.v)
  end

  def /(other : Float)
    LogNum.new(v - other)
  end

  def /(other : self)
    LogNum.new(v - other.v)
  end

  def **(n : Int)
    LogNum.new(v * n)
  end

  def <(other : self)
    v < other.v
  end

  def to_f
    Math.exp(v)
  end

  def to_i
    to_f.round.ceil
  end

  # 自然対数の底から10を底に
  def to_log10
    LogNum.new(v / Math.log(10))
  end
end