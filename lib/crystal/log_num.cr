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
  MAX = 200_000

  @@log = Array(LogNum).new(MAX)
  @@ft = Array(LogNum).new(MAX)

  def self.from(n : Int)
    @@log << new(Math.log(1)) if @@log.empty?
    @@log.size.upto(n) do |i|
      @@log << new(Math.log(i))
    end
    @@log[n]
  end

  def self.f(n : Int)
    @@ft << LogNum.from(1) if @@ft.empty?
    @@ft.size.upto(n) do |i|
      @@ft << @@ft[-1] * i
    end
    @@ft[n]
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

  def to_f
    Math.exp(v)
  end

  def to_i
    to_f.round.ceil
  end
end