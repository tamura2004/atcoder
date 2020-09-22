record LogNum, v : Float64 do
  @@ft = Array(LogNum).new(200_000)

  def self.from(n : Number)
    new(Math.log(n))
  end

  def self.ft
    @@ft
  end

  def self.f(n)
    ft << LogNum.from(1) if ft.empty?
    ft.size.upto(n) do |i|
      ft << ft[-1] * i
    end
    ft[n]
  end

  def self.p(n, k)
    f(n) / f(n - k)
  end

  def self.c(n, k)
    p(n, k) / f(k)
  end

  def self.r(n, k)
    c(n + k - 1, k)
  end

  def self.zero
    new(0)
  end

  def *(n : Number)
    LogNum.new(v + LogNum.from(n).v)
  end

  def *(other : self)
    LogNum.new(v + other.v)
  end

  def /(n : Number)
    LogNum.new(v - LogNum.from(n).v)
  end

  def /(other : self)
    LogNum.new(v - other.v)
  end

  def **(n : Number)
    LogNum.new(v * n)
  end

  def to_num
    Math.exp(v)
  end
end