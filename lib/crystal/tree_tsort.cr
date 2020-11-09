class Tree(T)
  getter n : Int32
  getter g : Array(Array(T))

  def self.read
    n = gets.to_s.to_i
    g = Array.new(n) { [] of T }
    (n - 1).times do
      a, b = gets.to_s.split.map { |v| v.to_i }
      a -= 1
      b -= 1
      g[a] << b
      g[b] << a
    end
    new(n, g)
  end

  def initialize(@n, @g)
  end

  def tsort
    sorted = [] of Int32
    gg = Array.new(n){ [] of T }

    seen = Array.new(n, false)
    q = [0]
    seen[0] = true
    while q.size > 0
      v = q.pop
      sorted << v
      g[v].each do |nv|
        next if seen[nv]
        seen[nv] = true
        gg[v] << nv
        q << nv
      end
    end
    @g = gg
    return sorted.reverse
  end

  def solve
    dp = Array.new(n, Complex(Int64).new(1_i64, 0_i64))
    tsort.each do |i|
      black = 1_i64
      white = 1_i64
      
      g[i].each do |j|
        black *= dp[j].imag
        black %= MOD
        white *= dp[j].manhattan
        white %= MOD
      end

      dp[i] = Complex(Int64).new(black, white)
    end
    return dp[0].manhattan % MOD
  end
end

t = Tree(Int32).read
puts t.solve
