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

class FormalPowerSeries(T)
  getter n : Int32
  getter a : Array(T)
  delegate "[]=", "size", to: a

  def initialize
    @n = 0
    @a = [] of T
  end

  def initialize(a : Array(U)) forall U
    @a = a.map { |v| T.new(v) }
    @n = a.size
  end

  def initialize(n : Int)
    @n = n.to_i
    @a = Array.new(n, T.zero)
  end

  def [](i)
    i < n ? a[i] : T.zero
  end

  def <<(v)
    @a << T.new(v)
    @n += 1
  end

  {% for op in %w(+ -) %}
    def {{op.id}}(b : self)
      m = Math.max(n, b.n)
      FormalPowerSeries(T).new(
        Array.new(m) do |i|
          self[i] {{op.id}} b[i]
        end
      )
    end
  {% end %}

  def *(b : self)
    FormalPowerSeries(T).new((n - 1) + (b.n - 1) + 1).tap do |ans|
      n.times do |i|
        b.n.times do |j|
          ans[i + j] += a[i] * b[j]
        end
      end
    end
  end

  def to_s
    a.zip(0..).reverse.map do |v, i|
      case
      when v.zero?          then nil
      when i.zero?          then "#{v}"
      when i == 1 && v == 1 then "x"
      when i == 1           then "#{v}x"
      when v == 1           then "x^#{i}"
      else                       "#{v}x^#{i}"
      end
    end.compact.join(" + ")
  end

  def inspect
    to_s
  end
end

require "crystal/mod_int"

alias FPS = FormalPowerSeries(ModInt)

require "crystal/graph"
X = FPS{0,1}

n = gets.to_s.to_i
g = Graph.new(n)
(n - 1).times do
  g.read
end

dp_a = Array.new(n) { FPS.new }
dp_b = Array.new(n) { FPS.new }
dp_c = Array.new(n) { FPS.new }

dfs = uninitialized (Int32, Int32) -> Nil
dfs = -> (v : Int32, pv : Int32) do
  abxc = FPS{1} # PI nv in ch, (dp_a[nv] + dp_b[nv] + x * dp_c[nv])
  abc = FPS{1} # PI nv in ch, (dp_a[nv] + dp_b[nv] + dp_c[nv])
  bc = FPS{1} # PI nv in ch, (dp_b[nv] + dp_c[nv])

  g.each(v) do |nv|
    next if nv == pv
    dfs.call(nv, v)

    abxc *= dp_a[nv] + dp_b[nv] + dp_c[nv] * X
    abc *= dp_a[nv] + dp_b[nv] + dp_c[nv]
    bc *= dp_b[nv] + dp_c[nv]
  end

  dp_a[v] = abxc * X
  dp_b[v] = abc * X - bc * X
  dp_c[v] = bc
end
dfs.call(0, -1)

puts (dp_a[0] + dp_b[0] + dp_c[0]).a.join("\n")
