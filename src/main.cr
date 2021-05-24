macro chmin(target, other)
  {{target}} = ({{other}}) if ({{target}}) > ({{other}})
end

class Problem
  getter n : Int32
  getter a : Array(Int64)
  getter dp : Array(Array(Int64?))
  INF = Int64::MAX//4

  def initialize
    @n = gets.to_s.to_i
    @a = gets.to_s.split.map(&.to_i64)
    @dp = Array.new(n*2) { Array.new(n*2) { nil.as(Int64?) } }
  end

  def solve(i, j)
    dp[i][j] ||= _solve(i,j)
  end

  def _solve(i, j)
    case
    when (j - i).even?
      INF
    when j - i == 1
      dist(i, j)
    else
      cnt = dist(i, j) + solve(i+1, j-1)
      (i+1).upto(j-2) do |k|
        chmin cnt, solve(i,k) + solve(k+1,j)
      end
      cnt
    end
  end

  private def dist(i, j)
    (a[i] - a[j]).abs
  end

  def show
    pp solve(0,n*2-1)
  end
end

Problem.new.show
