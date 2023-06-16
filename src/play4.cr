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

alias X = Tuple(Int64, Int64)
alias A = Int64

st = LST(X, A).new(
  values: Array.new(10) { {0_i64, 1_i64} },
  fxx: ->(x : X, y : X) { x + y },
  fxa: ->(x : X, a : A) { x * a },
  faa: ->(a : A, b : A) { b }
)

st[1] = {10i64, 1i64}
st[3] = {20i64, 1i64}
st[5] = {40i64, 1i64}

pp st.x.zip(0..)
pp st.query(2,4)
