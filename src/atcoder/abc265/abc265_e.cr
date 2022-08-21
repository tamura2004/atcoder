require "crystal/modint9"
require "crystal/complex"

# divn3(3) do |a|
#   pp! a
# end
# exit

n, m = gets.to_s.split.map(&.to_i64)
a, b, c, d, e, f = gets.to_s.split.map(&.to_i64)

class Problem
  getter a : Int64
  getter b : Int64
  getter c : Int64
  getter d : Int64
  getter e : Int64
  getter f : Int64

  def initialize(@a, @b, @c, @d, @e, @f)
  end

  def pos(i, j, k)
    x = a*i + c*j + e*k
    y = b*i + d*j + f*k
    {x, y}
  end
end

pr = Problem.new(a, b, c, d, e, f)

ng = Set(Tuple(Int64, Int64)).new
m.times do
  x, y = gets.to_s.split.map(&.to_i64)
  ng << {x, y}
end

# 300を３分割、C(302,2)
# nを３分割、C(n+2,2)

dp = Hash(Tuple(Int64, Int64, Int32), ModInt).new(0.to_m)
dp[{0_i64, 0_i64, 0}] = 1.to_m
ans = 0.to_m

(1..n).each do |i|
  divn3(i) do |s, t, u|
    x, y = pr.pos(s, t, u)
    next if ng.includes?({x, y})

    if s > 0
      nx, ny = pr.pos(s - 1, t, u)

      dp[{x, y, i}] += dp[{nx, ny, i - 1}]
    end

    if t > 0
      nx, ny = pr.pos(s, t - 1, u)

      dp[{x, y, i}] += dp[{nx, ny, i - 1}]
    end

    if u > 0
      nx, ny = pr.pos(s, t, u - 1)

      dp[{x, y, i}] += dp[{nx, ny, i - 1}]
    end

    if i == n
      # pp! [i,x,y,dp[{x, y}]]
      ans += dp[{x, y, i}]
    end
  end
end

# pp dp
pp ans

def divn3(n)
  (0..n).each do |lo|
    (lo..n).each do |hi|
      yield ({lo, hi - lo, n - hi})
    end
  end
end
