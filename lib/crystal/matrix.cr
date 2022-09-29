class Matrix(T)
  getter n : Int32
  getter a : Array(Array(T))

  def self.zero(n)
    Matrix(T).new(n) { T.zero }
  end

  def self.eye(n)
    Matrix(T).new(n) { |i, j| i == j ? T.zero + 1 : T.zero }
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

  def initialize(b : Array(U)) forall U
    @n = b.size
    @a = Array.new(n) { |i| Array.new(n) { |j| T.new(b[i][j]) } }
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

  # 2行2列の固有値1の場合の逆行列
  def inv
    self.class.new(n) do |i, j|
      case {i, j}
      when {0, 0} then self[1, 1]
      when {1, 1} then self[0, 0]
      when {1, 0} then -self[1, 0]
      when {0, 1} then -self[0, 1]
      else             raise "2行2列で固有値1の行列のみ"
      end
    end
  end

  def trace
    n.times.sum do |i|
      self[i, i]
    end
  end

  def tr
    trace
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
    a.map(&.map { |v| "%#{w}s" % v }.join(" ")).join("\n")
  end
end

# # 数Tを要素とする行列
# struct Matrix(T)
#   getter h : Int32           # 行数
#   getter w : Int32           # 列数
#   getter a : Array(Array(T)) # 要素

#   class DimensionMismatch < Exception
#   end

#   def initialize(@a)
#     @h = a.size
#     @w = a.first.size
#   end

#   # n次の単位行列を生成する
#   def self.identity(n)
#     a = Array.new(n) { Array.new(n, T.zero) }
#     n.times { |i| a[i] += 1 }
#     new(a)
#   end

#   # :ditto:
#   def self.unit(n)
#     identity(n)
#   end

#   # :ditto:
#   def self.i(n)
#     identity(n)
#   end

#   # rows[i]を第i行とする行列を生成する
#   def self.[](*rows)
#     new(rows.to_a)
#   end

#   # ブロックの返り値から行列を生成する
#   def self.build(h, w)
#     a = Array.new(h) do |y|
#       Array.new(w) do |x|
#         yield y, x
#       end
#     end
#     new(a)
#   end

#   # 列ベクトルbを右から乗じた列ベクトルを返す
#   def *(b : Array(T))
#     raise DimensionMismatch.new("#{b.size} != #{w}") if b.size != w

#     (0...h).map do |i|
#       a[i].zip(b).sum { |x, y| x * y }
#     end
#   end

#   # 行列を右から乗じた結果の行列を返す
#   def *(b : self)
#     raise DimensionMismatch.new if w != b.h
#     t = b.columns
#     self.class.new(
#       (0...h).map do |i|
#         b.columns.map do |t|
#           a[i].zip(t).sum { |i, j| i*j }
#         end
#       end
#     )
#   end

#   # 列ベクトルを返す
#   def columns
#     a.transpose
#   end

#   # rowsを行ベクトルの列とする行列を生成
#   # 引数copyがfalseならrowsの複製を行わない
#   def self.rows(rows, copy = true)
#     copy ? new(rows) : new(rows.map(&.dup))
#   end
# end

# a = Matrix(Int32).rows([[1, 2, 3], [3, 4, 5]])
# b = Matrix(Int32).rows([[1, 2], [3, 4], [5, 6]])
# pp a * b
