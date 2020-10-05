struct Matrix(T)
  getter n : Int32
  getter a : Array(Array(T))
  delegate "[]", to: a

  def initialize(@n : Int32)
    @a = Array.new(n) { Array.new(n, T.zero) }
  end

  def initialize(@a : Array(Array(T)))
    @n = a.size
  end

  def *(other : self)
    ans = Array.new(n) { Array.new(n, T.zero) }
    n.times do |i|
      n.times do |j|
        n.times do |k|
          ans[i][j] ^= a[i][k] & other[k][j]
        end
      end
    end
    Matrix(T).new(ans)
  end

  def **(k : Int)
    n = Math.ilogb(k) + 1
    ans = eye
    b = eye * self
    n.times do |i|
      if k >> i & 1 == 1
        ans *= b
      end
      b *= b
    end
    ans
  end

  def eye
    ans = Array.new(n) { Array.new(n, T.zero) }
    n.times do |i|
      ans[i][i] = ~T.zero
    end
    Matrix(T).new(ans)
  end
end
