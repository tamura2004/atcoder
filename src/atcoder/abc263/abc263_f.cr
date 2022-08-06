h = gets.to_s.to_i64
n = 1 << h
c = Array.new(n) { gets.to_s.split.map(&.to_i64) }

Problem.new(n,c).show


class Problem
  getter n : Int32
  getter c : Array(Array(Int64))
  getter ans : Int64

  def initialize(@n,@c)
    @ans = 0_i64
  end

  def solve(lo, hi, n)
    pp! [lo, hi, n]
    return if (lo..hi).size == n

    n >>= 1

    if lo < n
      solve(n, n*2, n)
    else
      solve(0, n - 1, n)
    end

    rlo, qlo = lo.divmod(n)
    rhi, qhi = hi.divmod(n)

    if qlo > 0
      solve(0 + rlo*n, qlo - 1 + rlo*n, qlo)
    end

    if qhi < n - 1
      solve(qhi + 1 + n*rhi, n - 1 + n*rhi, n - qhi - 1)
    end
  end

  def show
    solve(10, 11, 16)
  end
end


