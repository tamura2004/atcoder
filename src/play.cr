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
  def *(b : Indexable(T))
    raise DimensionMismatch.new("#{b.size} != #{w}") if b.size != w

    (0...h).map do |i|
      a[i].zip(b).sum { |x, y| x * y }
    end
  end
end

m = Matrix(Int32)[[1,2],[3,4]]
pp m * [5,6]
