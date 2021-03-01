class Matrix(T)
  getter n : Int32
  getter a : Array(Array(T))
 
  def self.zero(n)
    new(n) { T.zero }
  end
 
  def self.eye(n)
    new(n) { |i, j| i == j ? T.zero + 1 : T.zero }
  end
 
  def initialize(@n)
    @a = Array.new(n) { |i| Array.new(n) { |j| yield i, j } }
  end
 
  def initialize(@a)
    @n = a.size
  end
 
  def *(b : self) : self
    Matrix(T).new(n) do |i, j|
      ans = T.zero
      n.times do |k|
        ans += self[i, k] * b[k, j]
      end
      ans
    end
  end

  def **(k : Int) : self
    ans = Matrix(T).eye(n)
    m = Math.ilogb(k) + 1
    b = dup
    m.times do |i|
      ans *= b if (k>>i).odd?
      b *= b
    end
    ans
  end
 
  @[AlwaysInline]
  def [](i,j)
    a[i][j]
  end
 
  @[AlwaysInline]
  def []=(i,j,x)
    a[i][j] = x
  end

  def ==(b : self) : Bool
    n.times.all? do |i|
      n.times.all? do |j|
        self[i, j] == b[i, j]
      end
    end
  end
end

record ModInt, v : Int64 do
  MOD = 10_i64 ** 9 + 7
  def +(b); ModInt.new((v + b.to_i64 % MOD) % MOD); end
  def -(b); ModInt.new((v + MOD - b.to_i64 % MOD) % MOD); end
  def *(b); ModInt.new((v * (b.to_i64 % MOD)) % MOD); end
  def **(b)
    a = self
    ans = ModInt.new(1_i64)
    while b > 0
      ans *= a if b.odd?
      b //= 2
      a *= a
    end
    return ans
  end
  def self.zero; new(0); end
  def self.one; new(1); end
  def to_i64; v; end
  delegate to_s, to: @v
  delegate inspect, to: @v
end

unit = Matrix(ModInt).new([
  [ModInt.one, ModInt.one],
  [ModInt.one, ModInt.zero],
])

pp unit ** 10