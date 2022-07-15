require "crystal/ntt_convolution"
require "crystal/fps"

# n = gets.to_s.to_i64
# a = [1, 0, 0, 0, 1, 1, 3]
# b = [1, -1, -2, 0, 2, 4, -1, -3, -3, -1, 4, 2, 0, -2, -1, 1]
# ans = BostonMori.new(a, b).solve(n-6)
# pp ans
# (1 + x^4 + x^5 + 3 x^6)/(1 - x - 2 x^2 + 2 x^4 + 4 x^5 - x^6 - 3 x^7 - 3 x^8 - x^9 + 4 x^10 + 2 x^11 - 2 x^13 - x^14 + x^15)
class BostonMori
  getter p : Array(Int64)
  getter q : Array(Int64)

  def initialize(p : Array(U), q : Array(U)) forall U
    @p = p.map(&.to_i64)
    @q = q.map(&.to_i64)
  end

  def initialize(s : String, t : String)
    @p = FPS::Parser.new(s).parse.to_a.map(&.to_i64)
    @q = FPS::Parser.new(t).parse.to_a.map(&.to_i64)
  end

  def solve(n)
    q_rev = rev(q)
    while n > 0
      @p = convolution(p, q_rev)
      @p = n.odd? ? odd(p) : even(p)
      @q = convolution(q, q_rev)
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
