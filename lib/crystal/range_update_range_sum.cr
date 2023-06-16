require "crystal/lst"

struct Tuple
  def +(other : Tuple)
    {% begin %}
      Tuple.new(
        {% for i in 0...@type.size %}
          self[{{i}}] + other[{{i}}],
        {% end %}
      )
    {% end %}
  end

  def *(a : Int)
    Tuple.new(self[1] * a, self[1])
  end
end

ZERO = {0_i64, 1_i64}

class RangeUpdateRangeSum
  alias X = Tuple(Int64, Int64)
  alias A = Int64

  getter st : LST(X, A)

  def initialize(n)
    @st = LST(X, A).new(
      values: Array.new(n) { ZERO },
      fxx: ->(x : X, y : X) { x + y },
      fxa: ->(x : X, a : A) { x * a },
      faa: ->(a : A, b : A) { b },
    )
  end

  def [](r)
    st[r][0]
  end

  def []=(i : Int, v)
    st[i] = {v, 1_i64}
  end

  def []=(r : Range, v)
    st[r] = v
  end
end

alias RURS = RangeUpdateRangeSum
