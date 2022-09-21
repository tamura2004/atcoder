# 数Tを要素とする行列
struct Matrix(T)
  getter h : Int32           # 行数
  getter w : Int32           # 列数
  getter a : Array(Array(T)) # 要素

  class DimensionMismatch < Exception
  end

  def initialize(@a)
    @h = a.size
    @w = a.first.size
  end

  # n次の単位行列を生成する
  def self.identity(n)
    a = Array.new(n) { Array.new(n, T.zero) }
    n.times { |i| a[i] += 1 }
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
  def self.build(h, w)
    a = Array.new(h) do |y|
      Array.new(w) do |x|
        yield y, x
      end
    end
    new(a)
  end

  # 列ベクトルbを右から乗じた列ベクトルを返す
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

  # 列ベクトルを返す
  def columns
    a.transpose
  end

  # rowsを行ベクトルの列とする行列を生成
  # 引数copyがfalseならrowsの複製を行わない
  def self.rows(rows, copy = true)
    copy ? new(rows) : new(rows.map(&.dup))
  end
end

a = Matrix(Int32).rows([[1, 2, 3], [3, 4, 5]])
b = Matrix(Int32).rows([[1, 2], [3, 4], [5, 6]])
pp a * b
