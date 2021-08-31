require "crystal/ntt_convolution"

class BostonMori
  getter p : Array(Int64)
  getter q : Array(Int64)

  def initialize(p, q)
    @p = p.map(&.to_i64)
    @q = q.map(&.to_i64)
  end

  def solve(n)
    q_rev = rev(q)
    while n > 0
      @p = convolution(p, q_rev, 998244353)
      @p = n.odd? ? odd(p) : even(p)
      @q = convolution(q, q_rev, 998244353)
      @q = even(q)
      q_rev = q
      q_rev = rev(q)
      n //= 2
    end
    p[0] // q[0]
  end

  private def rev(p)
    p.map_with_index do |v, i|
      i.odd? ? -v : v
    end
  end

  private def even(p)
    p.zip(0..).select(&.last.even?).map(&.first)
  end

  private def odd(p)
    p.zip(0..).select(&.last.odd?).map(&.first)
  end
end
