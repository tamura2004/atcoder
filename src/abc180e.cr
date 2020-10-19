macro chmin(target, other)
  {{target}} = ({{other}}) if ({{target}}) > ({{other}})
end

class Town
  getter x : Int64
  getter y : Int64
  getter z : Int64

  def initialize(@x, @y, @z)
  end

  def from(b : self)
    (x - b.x).abs + (y - b.y).abs + Math.max(0, z - b.z)
  end

  def -(b : self)
    (x - b.x).abs + (y - b.y).abs + Math.max(0, z - b.z)
  end
end

# bit dp
# S < {0,1,...,n-1}, n
# dp[S,n] := 集合S内の町をすべて訪れて、最後に町nにいるときの総距離の最小値
# dp[S|{n}, n] = dp[S,m] + dist[m,n]

class Problem
  getter n : Int32
  getter ts : Array(Town)
  getter dp : Array(Array(Int64))

  def self.read
    n = gets.to_s.to_i
    ts = Array.new(n) do
      x, y, z = gets.to_s.split.map { |v| v.to_i64 }
      Town.new(x, y, z)
    end
    new(n, ts)
  end

  def initialize(@n, @ts)
    @dp = Array.new(1 << n) { Array.new(n, Int64::MAX >> 1) }
    dp[1][0] = 0
  end

  def solve
    (1 << n).times do |s|
      n.times do |i|
        n.times do |j|
          next if s.bit(j).zero?
          chmin dp[s | (1 << i)][i], dp[s][j] + (ts[i] - ts[j])
        end
      end
    end

    dp[-1][0]
  end

  def run
    puts solve
  end
end

Problem.read.run
