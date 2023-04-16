# 正方行列
class SquareMatrix(T)
  getter n : Int32
  getter a : Array(T)

  def initialize(@n : Int32)
    @a = Array.new(n*n, T.zero)
  end

  def initialize(@a : Array(T))
    @n = Math.sqrt(a.size).to_i
  end

  def initialize(a : Array(Array(T)))
    @n = a.size
    @a = a.flatten
  end

  def initialize(a : Array(Array(Int32)))
    @n = a.size
    @a = a.flatten.map { |v| T.new(v) }
  end

  def initialize(s : String)
    rows = s.split(/;/)
    @n = rows.size
    @a = rows.map(&.split.map(&.to_i64).map { |v| T.new(v) }).flatten
  end

  def *(b : self)
    ans = Array.new(n*n, T.zero)
    n.times do |i|
      n.times do |j|
        n.times do |k|
          ans[i*n + j] += a[i*n + k] * b.a[k*n + j]
        end
      end
    end
    self.class.new(ans)
  end

  def unit
    ans = Array.new(n*n, T.zero)
    n.times do |i|
      ans[i*n + i] += 1
    end
    self.class.new(ans)
  end

  def **(k : Int)
    ans = unit
    tot = self
    while k > 0
      ans *= tot if k.odd?
      tot *= tot
      k >>= 1
    end
    ans
  end

  def [](i, j)
    a[i*n + j]
  end

  def inspect(io)
    ans = [] of String
    a.each_slice(n) do |row|
      ans << row.join(" ")
    end
    io << "|" + ans.join(";") + "|"
  end
end
