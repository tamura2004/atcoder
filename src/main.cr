require "crystal/bit_set"

class Graph
  getter n : Int32
  getter g : Array(Int64)

  def self.read
    n, m = gets.to_s.split.map(&.to_i)
    g = Array.new(n, 0_i64)
    m.times do
      a, b = gets.to_s.split.map(&.to_i.- 1)
      g[a] |= b.exp2
      g[b] |= a.exp2
    end
    new(n, g)
  end

  def initialize(@n, @g)
  end

  def cleak?(s)
    s.bits.all? do |i|
      s.bits.all? do |j|
        i == j || g[i].bit(j) == 1
      end
    end
  end

  def remove_cleak(s)
    ng = g.dup
    s.bits.each do |i|
      s.bits.each do |j|
        ng[i] = ng[i].off(j)
      end
    end
    Graph.new(n, ng)
  end

  def max_cleak
    ans = 0_i64
    (1<<n).times do |s|
      if cleak?(s)
        if ans.popcount < s.popcount
          ans = s
        end
      end
    end
    ans
  end

  def print
    puts g.map(&.to_bit(n).reverse).join("\n")
  end
  
  def solve
    dp = Array.new(1<<n, 0_i64)
    (1<<n).times do |s|
      next if s.zero?
      if cleak?(s)
        dp[s] = 1_i64
      else
        dp[s] = s.subsets.min_of do |t|
          next Int64::MAX if s == t
          dp[t] + dp[s & t.inv(n)]
        end
      end
    end
    dp[-1]
  end
end

g = Graph.read
# g.print
pp g.solve
