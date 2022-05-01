class Matrix(T)
  getter n : Int32
  getter a : Array(Array(T))

  def self.zero(n)
    new(n) { T.zero }
  end

  def self.eye(n)
    new(n) { |i, j| i == j ? T.zero + 1 : T.zero }
  end

  # ブロックで初期化
  def initialize(@n : Int32)
    @a = Array.new(n) { |i| Array.new(n) { |j| yield i, j } }
  end
  
  def initialize(n : Int64)
    @n = n.to_i
    @a = Array.new(n) { |i| Array.new(n) { |j| yield i, j } }
  end

  # 配列で初期化
  def initialize(@a : Array(Array(T)))
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

  def *(b : Array(Int))
    a.map do |v|
      v.zip(b).sum { |x, y| x*y }
    end
  end

  {% for op in %w(+ - * //) %}
    def {{op.id}}(b : Int)
      n.times do |y|
        n.times do |x|
          @a[y][x] {{op.id}}= b
        end
      end
      self
    end
  {% end %}

  def **(k : Int) : self
    ans = Matrix(T).eye(n)
    m = Math.ilogb(k) + 1
    b = dup
    m.times do |i|
      ans *= b if (k >> i).odd?
      b *= b
    end
    ans
  end

  def inv
    b = a.zip(Matrix(T).eye(n).a).map { |u, v| u + v }
  end

  @[AlwaysInline]
  def [](i, j)
    a[i][j]
  end

  @[AlwaysInline]
  def [](i)
    a[i]
  end

  @[AlwaysInline]
  def []=(i, j, x)
    a[i][j] = x
  end

  def ==(b : self) : Bool
    n.times.all? do |i|
      n.times.all? do |j|
        self[i, j] == b[i, j]
      end
    end
  end

  def inspect
    w = a.flatten.map(&.to_s.size).max
    a.map(&.map{|v|"%#{w}s" % v}.join(" ")).join("\n")
  end
end
