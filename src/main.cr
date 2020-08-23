class Problem
  property :a, :b, :c, :d, :e, :f, :g, :h, :i, :j, :k, :l, :m, :n, :o, :p, :q, :r, :s, :t, :u, :v, :w, :x, :y, :z

  @n : Int32
  @a : Array(Array(Int64))
  @b : Array(Int32)

  def initialize
    @n = gets.to_s.to_i
    @a = Array.new(n){ gets.to_s.split.map(&.to_i64) }
    @b = Array.new(n){ |i| i }
  end

  def is_diag?
    n.times.all? do |i|
      a[i][i].zero? &&
      n.times.all? do |j|
        a[i][j] == a[j][i]
      end
    end
  end

  def valid?
    b.combinations(3).each.all? do |(i,j,k)|
      x = a[i][j]
      y = a[j][k]
      z = a[k][i]
      x <= y + z && y <= x + z && z <= x + y
    end
  end

  def calc
    ans = 0_i64
    b.combinations(2).each do |(i,j)|
      next if b.each.any? { |k|
        i != k &&
        j != k &&
        a[i][j] >= a[i][k] + a[k][j]
      }
      ans += a[i][j]
    end
    ans
  end

  def solve
    return -1 if !is_diag?
    return 0 if n == 1
    return a[1][0] if n == 2
    return -1 if !valid?
    calc
  end

  def show(ans)
  end
end

Problem.new.try do |me|
  puts me.solve
end