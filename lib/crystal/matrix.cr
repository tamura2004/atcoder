class Vector(T, N)
  getter a : Array(T)

  def initialize(@a)
  end

  def initialize
    @a = Array.new(N){ |i| yield i }
  end

  def get(i)
    a[i]
  end

  def [](i)
    get(i)
  end

  def set(i,x)
    a[i] = x
  end

  def []=(i,x)
    set(i,x)
  end
end

class Matrix(T, N)
  getter a : Array(Array(T))

  def self.zero
    new { T.zero } 
  end

  def self.eye
    new { |i, j| i == j ? T.zero + 1 : T.zero } 
  end

  def initialize
    @a = Array.new(N) { |i| Array.new(N) { |j| yield i, j } }
  end

  def initialize(@a)
  end

  def set(i,j,x)
    a[i][j] = x
  end

  def []=(i,j,x)
    set(i,j,x)
  end

  def get(i,j)
    a[i][j]
  end

  def row(i)
    a[i]
  end

  def [](i,j)
    get(i,j)
  end

  def [](i)
    row(i)
  end

  def *(b : self) : self
    Matrix(T, N).new do |i, j|
      N.times.sum do |k|
        self[i, k] * b[k, j]
      end
    end
  end

  def *(v : Vector(T, N)) : Vector(T, N)
    Vector(T, N).new do |i|
      N.times.sum do |j|
        self[i,j] * v[j]
      end
    end
  end

  def **(k : Int) : self
    n = Math.ilogb(k) + 1
    ans = Matrix(T, N).eye
    b = Matrix(T, N).eye * self
    N.times do |i|
      if k.bit(i) == 1
        ans *= b
      end
      b *= b
    end
    ans
  end

  def ==(b : self)
    N.times.all? { |i| self[i] == b[i]}
  end

  def pp
    puts a.map(&.join(" ")).join("\n")
  end
end
