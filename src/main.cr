MASK = 1_i64 << 32 - 1

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

  def initialize(@n, @a)
  end

  def set(i, j, x)
    a[i][j] = x
  end

  def []=(i, j, x)
    set(i, j, x)
  end

  def get(i, j)
    a[i][j]
  end

  def row(i)
    a[i]
  end

  def [](i, j)
    get(i, j)
  end

  def [](i)
    row(i)
  end

  def *(b : self) : self
    Matrix(T).new(n) do |i, j|
      n.times.sum do |k|
        (self[i, k] * b[k, j]) % 10000
      end
    end
  end

  def *(v : Array(T))
    Array.new(n) do |i|
      n.times.sum do |j|
        self[i, j] * v[j]
      end
    end
  end

  def **(k : Int) : self
    n = Math.ilogb(k) + 1
    ans = Matrix(T).eye
    b = Matrix(T).eye * self
    n.times do |i|
      if k.bit(i) == 1
        ans *= b
      end
      b *= b
    end
    ans
  end

  def ==(b : self)
    n.times.all? { |i| self[i] == b[i] }
  end

  def pp
    puts a.map(&.join(" ")).join("\n")
  end
end

class SegmentTree(T)
  getter n : Int32
  getter unit : T
  getter xs : Array(T)
  getter fx : Proc(T, T, T)

  def initialize(n : Int32, init : T = T.zero)
    values = Array.new(n) { init }
    initialize(values)
  end

  def initialize(values : Array(T), unit : T = T.zero, &fx : Proc(T, T, T))
    initialize(values, unit, fx)
  end

  def initialize(
    values : Array(T),
    @unit : T = T.zero,
    @fx : Proc(T, T, T) = Proc(T, T, T).new { |x, y| x + y }
  )
    @n = Math.pw2ceil(values.size)
    @xs = Array(T).new(n*2, unit)

    values.each_with_index do |v, i|
      xs[i + n] = v
    end

    (n - 1).downto(1) do |i|
      xs[i] = fx.call xs[i << 1], xs[i << 1 | 1]
    end
  end

  def set(i : Int32, v : T)
    raise "Bad index i=#{i}" unless (0...n).includes?(i)

    i += n
    xs[i] = v
    while i > 1
      i >>= 1
      xs[i] = fx.call xs[i << 1], xs[i << 1 | 1]
    end
  end

  def []=(i : Int32, v : T)
    set(i, v)
  end

  def get(i : Int32) : T
    xs[i + n]
  end

  def [](i : Int32) : T
    get(i)
  end

  def sum(i : Int32, j : Int32) : T
    raise "Bad index i=#{i}" unless (0...n).includes?(i)
    raise "Bad index j=#{j}" unless (1..n).includes?(j)

    i += n; j += n
    left = right = unit
    while i < j
      if i.odd?
        left = fx.call left, xs[i]
        i += 1
      end

      if j.odd?
        j -= 1
        right = fx.call xs[j], right
      end
      i >>= 1; j >>= 1
    end

    fx.call(left, right)
  end

  def [](r : Range(Int32?, Int32?)) : T
    lo = r.begin || 0
    hi = (r.end || n - 1) + (r.excludes_end? ? 0 : 1)
    sum(lo, hi)
  end

  def pp
    puts "========"
    i = 1
    while i <= n
      sep = " " * ((n * 2) // i - 1)
      puts xs[i...(i << 1)].join(sep)
      i <<= 1
    end
    puts "--------"
  end
end

eye = Matrix(Int64).eye(6)
mx = Array.new(5) do |i|
  m = Matrix(Int64).eye(6)
  m[i + 1, i] = 1_i64
  m
end
s = gets.to_s.chars.map { |c| "DISCO".index(c).not_nil! }
a = s.map { |i| mx[i] }

st = SegmentTree(Matrix(Int64)).new(a, eye) do |a, b|
  b * a
end

q = gets.to_s.to_i
q.times do
  l,r = gets.to_s.split.map { |v| v.to_i - 1 }
  puts st[l..r][5,0]
end
