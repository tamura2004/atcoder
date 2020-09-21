# 桁DPの練習
#
# 問題
# 2780 から 4019の間で、桁の和が29であるものの個数を求めよ

class Problem
  attr_accessor :lo, :hi, :target
  def initialize
    @lo = 2
    @hi = 12
    @target = 2
  end

  # 桁dp
  def query(num) # Array(Int)
    num = num.digits.reverse
    n = num.size
    edge = Array.new(n+1) { Array.new(@target+1, 0) }
    less = Array.new(n+1) { Array.new(@target+1, 0) }
    edge[0][0] = 1
    n.times do |i|
      0.upto(@target) do |sum|
        10.times do |d|
          next if sum < d
          less[i+1][sum] += less[i][sum - d]
          if d == num[i]
            edge[i+1][sum] += edge[i][sum - d]
          elsif d < num[i]
            less[i+1][sum] += edge[i][sum - d]
          end
        end
      end
    end
    edge[n][target] + less[n][target]
  end

  def solve
    query(hi) - query(lo-1)
  end

  # 全探索
  def solve2
    (lo..hi).each.count do |i|
      i.digits.sum == target
    end
  end

  def show(ans)
    puts ans
  end
end

Problem.new.instance_eval do
  show(solve)
  show(solve2)
end