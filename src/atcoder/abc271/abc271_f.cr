class Problem
  getter n : Int32
  getter a : Array(Array(Int32))

  def initialize(@n, @a)
  end

  def diag
    (0...n).map { |i| a[n - 1 - i][i] }
  end

  def self.read
    n = gets.to_s.to_i
    a = Array.new(n) { gets.to_s.split.map(&.to_i) }
    new(n, a)
  end

  def make_dp
    Array.new(n) do |y|
      Array.new(n - y) { Hash(Int32, Int64).new(0i64) }
    end
  end

  def rec
    dp = make_dp

    dp[0][0][0] = 1_i64
    n.times do |y|
      n.times do |x|
        next unless x + y < n

        [{y, x - 1}, {y - 1, x}].each do |py, px|
          next if py < 0 || px < 0
          dp[py][px].each do |k, v|
            # dp[y][x][k ^ a[y][x]] += v
            dp[y][x][k] += v
          end
        end

        dp[y][x] = dp[y][x].transform_keys(&.^ a[y][x])
      end
    end

    (0...n).map { |i| dp[n - 1 - i][i] }
  end

  def solve
    rev = Problem.new(n, a.map(&.reverse).reverse)
    dp1 = rec
    dp2 = rev.rec.reverse
    d = diag

    ans = 0_i64
    n.times do |i|
      dp1[i].each do |k, v|
        k2 = k ^ d[i]
        if dp2[i].has_key?(k2)
          ans += v * dp2[i][k2]
        end
      end
    end

    ans
  end
end

ans = Problem.read.solve
pp ans
