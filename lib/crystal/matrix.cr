# 数Tを要素とする行列
# 列ベクトルは個別クラスとしては定義せずArray(T)を用いる
struct Matrix(T)
  getter h : Int32           # 行数
  getter w : Int32           # 列数
  getter a : Array(Array(T)) # 要素
  delegate "[]", "[]=", to: a

  class DimensionMismatch < Exception
  end

  def initialize(@a)
    @h = a.size
    @w = a.first.size
  end

  # ゼロ行列を生成する
  def self.zero(h, w = h)
    a = Array.new(h) { Array.new(w, T.zero)}
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
    raise DimensionMismatch.new if w != b.h
    t = b.columns
    self.class.new(
      (0...h).map do |i|
        b.columns.map do |t|
          a[i].zip(t).sum { |i, j| i*j }
        end
      end
    )
  end

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
    m = Math.ilogb(k) + 1
    b = dup
    m.times do |i|
      ans *= b if k.bit(i) == 1
      b *= b
    end
    ans
  end

  # 列ベクトルを返す
  def columns
    a.transpose
  end

  # rowsを行ベクトルの列とする行列を生成
  # 引数copyがfalseならrowsの複製を行わない
  def self.rows(rows, copy = true)
    copy ? new(rows) : new(rows.map(&.dup))
  end

  @[AlwaysInline]
  def [](i, j)
    a[i][j]
  end

  @[AlwaysInline]
  def []=(i, j, x)
    a[i][j] = x
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
    a.map(&.map { |v| "%#{w}s" % v }.join(" ")).join("\n")
  end
end