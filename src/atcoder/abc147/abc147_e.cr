require "crystal/bitset"

OFFSET = (80 + 80 - 1) * 80
SIZE = OFFSET * 2 + 1

class Problem
  getter h : Int32
  getter w : Int32
  getter a : Array(Array(Int64))
  getter b : Array(Array(Int64))

  def initialize(@h, @w, @a, @b)
  end

  def self.read
    h, w = gets.to_s.split.map(&.to_i)
    a = Array.new(h){ gets.to_s.split.map(&.to_i64) }
    b = Array.new(h){ gets.to_s.split.map(&.to_i64) }
    new(h, w, a, b)
  end

  def solve
    dp = Array.new(h){ Array.new(w){ SIZE.to_bitset } }
    h.times do |y|
      w.times do |x|
        wk = SIZE.to_bitset
        wk.set(OFFSET) if x.zero? && y.zero?
        wk.or! dp[y-1][x] if y > 0
        wk.or! dp[y][x-1] if x > 0
        abs = (a[y][x] - b[y][x]).abs
        dp[y][x] = (wk << abs) | (wk >> abs)
      end
    end

    ans = SIZE
    result = dp[-1][-1]

    SIZE.times do |i|
      if result.get(i) == 1
        chmin ans, (i - OFFSET).abs
      end
    end
    ans
  end

  def run
    puts solve
  end
end

Problem.read.run