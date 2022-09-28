# dp[vを根とする部分木][k警備されている頂点数][根の分類0,1,2] := 場合の数
# 0: 頂点が0で警備されていない
# 1: 頂点が0で警備されている
# 2: 頂点が1

# dp_a[0]
# dp_a[1]: x
# dp_a[2]: x

# dp_b[1]: 0
# dp_b[2]: 0

# dp_c[1]: 1
# dp_c[2]: 1

# dp_a[0] = x * PI i=0..1, dp_a[i] + dp_b[i] + x dp_x[i]
# = x (x + 0 + x)^2
# = 4x^3 -> 3つ警備されていて点0が1であるのは4通り　ok

require "crystal/indexable"

class Polynomial(T)
  getter n : Int32
  getter a : Array(T)
  delegate "[]=", "size", to: a

  def initialize(_a : Array(U)) forall U
    @a = _a.map { |v| T.new(v) }.reverse
    @n = _a.size
  end

  def initialize(n : Int)
    @n = n.to_i
    @a = Array.new(n, T.zero)
  end

  def [](i)
    if i < n
      a[i]
    else
      T.zero
    end
  end

  def +(b : self)
    m = Math.max(n, b.n)
    Polynomial(T).new(
      Array.new(m) do |i|
        self[i] + b[i]
      end
    )
  end

  def -(b : self)
    m = Math.max(n, b.n)
    Polynomial(T).new(
      Array.new(m) do |i|
        self[i] - b[i]
      end
    )
  end

  def *(b : self)
    Polynomial(T).new((n - 1) + (b.n - 1) + 1).tap do |ans|
      n.times do |i|
        b.n.times do |j|
          ans[i + j] += a[i] * b[j]
        end
      end
    end
  end

  def to_s
    # a.zip(0..).reverse.map{|v,i| "#{v}x^#{i}".gsub(/x\^0/,"").gsub(/x\^1/,"x").gsub(/^1x/,"x")}.join(" + ")
    a.zip(0..).reverse.map do |v, i|
      if i == 0
        v.zero? ? nil : "#{v}"
      elsif i == 1
        v.zero? ? nil : v == 1 ? "x" : "#{v}x"
      else
        v.zero? ? nil : v == 1 ? "x^#{i}" : "#{v}x^#{i}"
      end
    end.compact.join(" + ")
  end

  def inspect
    to_s
  end
end

require "crystal/graph"

n = gets.to_s.to_i
g = Graph.new(n)
(n - 1).times do
  g.read
end

f = Polynomial(Int64).new([2, 3])
g = Polynomial(Int64).new([1, 1])
pp f + g
pp f - g
