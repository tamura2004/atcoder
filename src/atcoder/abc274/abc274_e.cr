require "crystal/complex"

class Problem
  getter n : Int32
  getter m : Int32
  getter xy : Array(C)
  getter pq : Array(C)
  getter a : Array(C)

  def initialize(@n, @m, @xy, @pq)
    @a = xy + pq + [C.zero]
  end

  def self.read
    n, m = gets.to_s.split.map(&.to_i)
    xy = Array.new(n) { C.read }
    pq = Array.new(m) { C.read }
    new(n, m, xy, pq)
  end

  def solve
    dp = make_array(1e15, 1 << (n + m + 1), n + m + 1)
    (n + m).times do |i|
      dp[1 << i][i] = a[i].abs
    end

    (1 << (n + m + 1)).times do |s|
      spd = boost(s)
      (n + m + 1).times do |i|
        next if s.bit(i) == 0
        (n + m + 1).times do |j|
          next if s.bit(j) == 1

          chmin dp[s | (1 << j)][j], dp[s][i] + (a[j] - a[i]).abs / spd
        end
      end
    end

    ans = 1e15
    mask = ((1 << n) - 1) | (1 << (n + m))
    (1 << (n + m + 1)).times do |s|
      if s.bits_set?(mask)
        chmin ans, dp[s][n + m]
      end
    end
    ans
  end

  def boost(s)
    1_i64 << ((s & ((1 << (n + m)) - 1)) >> n).popcount
  end
end

pp Problem.read.solve
