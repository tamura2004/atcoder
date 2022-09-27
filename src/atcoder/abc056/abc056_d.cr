require "crystal/indexable"

# a[ex]以外のa[i]の部分和の存在判定
class PartialSum
  getter n : Int32
  getter k : Int32
  getter ex : Int32
  getter a : Array(Int64)
  getter dp : Array(Bool)

  def initialize(@n, @k, @ex, @a)
    @dp = Array.new(k, false)
    dp[0] = true
  end

  def solve
    n.times do |i|
      next if i == ex
      (0...k).reverse_each do |j|
        jj = j - a[i]
        break if jj < 0
        dp[j] ||= dp[jj]
      end
    end
    dp
  end
end

class Problem
  getter n : Int32
  getter k : Int32
  getter a : Array(Int64)

  def initialize(@n, @k, @a)
  end

  def self.read
    n, k = gets.to_s.split.map(&.to_i)
    a = gets.to_s.split.map(&.to_i64).sort
    new(n, k, a)
  end

  def solve
    lo = 0
    hi = n - 1
    (lo..hi).bsearch(&->query(Int32)) || n
  end

  # 必要なカードの条件
  # 自分以外の部分和にて、k-自身<=sumなるものが存在
  def query(i)
    dp = PartialSum.new(n, k, i, a).solve
    lo = Math.max k - a[i], 0i64
    (lo...k).any?(&.of dp)
  end
end

pp Problem.read.solve
