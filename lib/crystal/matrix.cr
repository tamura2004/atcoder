require "crystal/complex"

# 数Tを要素とする行列
# 列ベクトルは個別クラスとしては定義せずArray(T)を用いる
struct Matrix(T)
  getter h : Int32           # 行数
  getter w : Int32           # 列数
  getter a : Array(Array(T)) # 要素
  # delegate "[]", "[]=", to: a

  include Indexable(T)

  def size
    h * w
  end

  def unsafe_fetch(index : Int)
    y, x = index.divmod(w)
    a[y][x]
  end

  class DimensionMismatch < Exception
  end

  def initialize(@a : Array(Array(T)))
    @h = a.size
    @w = a.first.size
  end

  def initialize(z : C, v : T)
    @h = z.y.to_i
    @w = z.x.to_i
    @a = Array.new(h) do
      Array.new(w, v)
    end
  end

  # 空のマトリクス
  def initialize(z : C)
    @h = z.y.to_i
    @w = z.x.to_i
    @a = [] of Array(T)
  end

  def initialize(z : C, &block : -> Array(T))
    @h = z.y.to_i
    @w = z.x.to_i
    @a = [] of Array(T)
    h.times do
      @a << block.call()
    end
  end

  # 標準入力から値を読み込む
  def read
    h.times do |y|
      @a << gets.to_s.split.map { |v| T.new(v) }
    end
  end

  def map(&block : T -> U) forall U
    b = Matrix(U).new(z)
    h.times do |y|
      b << @a[y].map(&block)
    end
    b
  end

  def self.parse(s : String)
    a = s.split(/;/).map(&.split.map { |v| T.new(v.to_i64) })
    new(a)
  end

  def index(v : T)
    h.times do |y|
      w.times do |x|
        return {y, x} if a[y][x] == v
      end
    end
    return nil
  end

  # ゼロ行列を生成する
  def self.zero(h, w = h)
    a = Array.new(h) { Array.new(w, T.zero) }
    new(a)
  end

  # :ditto:
  def self.zero(z : C)
    a = Array.new(z.y) { Array.new(z.x, T.zero) }
    new(a)
  end

  # n次の単位行列を生成する
  def self.identity(n)
    a = Array.new(n) { Array.new(n, T.zero) }
    n.times { |i| a[i][i] += 1 }
    new(a)
  end

  # :ditto:
  def self.unit(n)
    identity(n)
  end

  # :ditto:
  def self.i(n)
    identity(n)
  end

  # rows[i]を第i行とする行列を生成する
  def self.[](*rows)
    new(rows.to_a)
  end

  # ブロックの返り値をaとして行列を生成する
  def self.from_rows(z : C)
    a = Array.new(z.y) do |y|
      yield y
    end
    new(a)
  end

  # ブロックの返り値から行列を生成する
  def self.build(h, w = h)
    a = Array.new(h) do |y|
      Array.new(w) do |x|
        yield y, x
      end
    end
    new(a)
  end

  # Arrayを列ベクトルとみなし右から乗じた列ベクトルを返す
  def *(b : Array(T))
    raise DimensionMismatch.new("#{b.size} != #{w}") if b.size != w

    (0...h).map do |i|
      a[i].zip(b).sum { |x, y| x * y }
    end
  end

  # 行列を右から乗じた結果の行列を返す
  def *(b : self)
    values = Array.new(h){ Array.new(w, T.zero)}
    h.times do |y|
      w.times do |x|
        w.times do |z|
          values[y][x] = self[y, z] * b[z, x]
        end
      end
    end
    self.class.new(values)
  end

  #   raise DimensionMismatch.new if w != b.h
  #   t = b.columns
  #   self.class.new(
  #     (0...h).map do |i|
  #       b.columns.map do |t|
  #         a[i].zip(t).sum { |i, j| i*j }
  #       end
  #     end
  #   )
  # end

  # スカラ加算・減算・乗算・整除
  {% for op in %w(+ - * //) %}
    def {{op.id}}(b : Int)
      Matrix(T).new(
        Array.new(h) do |y|
          Array.new(w) do |x|
            a[y][x] {{op.id}} b
          end
        end
      )
    end
  {% end %}

  # 正方行列か
  def square?
    h == w
  end

  # 正方行列について、繰り返し二乗法で累乗を計算する
  def **(k : Int)
    raise DimensionMismatch.new("正方行列ではありません") unless square?
    ans = Matrix(T).unit(h)
    b = dup
    while k > 0
      ans *= b if k.odd?
      b *= b
      k >>= 1
    end
    ans
  end

  # 列ベクトルを返す
  def columns
    a.transpose
  end

  # 行ベクトルを返す
  def rows
    a
  end

  # 行ベクトルを追加
  def <<(row : Array(T))
    @a << row
  end

  def max
    a.max_of(&.max)
  end

  def min
    a.min_of(&.min)
  end

  # rowsを行ベクトルの列とする行列を生成
  # 引数copyがfalseならrowsの複製を行わない
  def self.rows(rows, copy = true)
    copy ? new(rows) : new(rows.map(&.dup))
  end

  def transpose
    self.class.new(a.transpose)
  end

  # ::ditto::
  def flip_ld_ru
    transpose
  end

  def flip_lu_rd
    self.class.new(a.reverse.transpose.reverse)
  end

  # ::ditto::
  def flip_diag
    flip_lu_rd
  end

  def flip_lr
    self.class.new(a.map(&.reverse))
  end

  def flip_ud
    self.class.new(a.reverse)
  end

  def rot90
    self.class.new(a.transpose.map(&.reverse))
  end

  def rot180
    self.class.new(a.map(&.reverse).reverse)
  end

  def rot270
    self.class.new(a.transpose.reverse)
  end

  def z
    h.y + w.x
  end

  @[AlwaysInline]
  def [](i, j)
    a[i][j]
  end

  @[AlwaysInline]
  def [](i)
    a[i][i]
  end

  @[AlwaysInline]
  def [](z : C)
    a[z.y][z.x]
  end

  @[AlwaysInline]
  def []=(i, j, x)
    a[i][j] = x
  end

  @[AlwaysInline]
  def []=(z : C, v)
    a[z.y][z.x] = v
  end

  def ==(b : self) : Bool
    h.times.all? do |i|
      w.times.all? do |j|
        self[i, j] == b[i, j]
      end
    end
  end

  def inspect
    w = a.flatten.map(&.to_s.size).max
    z.to_s + "\n" + a.map(&.map { |v| "%#{w}s" % v }.join(" ")).join("\n")
  #   a.map(&.map.(&.join(" "))).join("\n")
  end

  def to_s(io)
    io << "["
    io << a.map(&.join(",")).join(";")
    io << "]"
  end
end
