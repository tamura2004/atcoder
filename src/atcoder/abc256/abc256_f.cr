# Dx = 1/2 Σ i^2Ai - (2x+3)/2 Σ i Ai + (x+1)(x+2)/2 Σ Ai
# と変形する
# i^2 Ai, iAi, Aiがそれぞれ独立に求まることがキモ

require "crystal/modint9"
require "crystal/segment_tree"

n, q = gets.to_s.split.map(&.to_i64)
a0 = gets.to_s.split.map(&.to_i64.to_m)
a1 = a0.map_with_index { |v, i| v * (i + 1) }
a2 = a0.map_with_index { |v, i| v * (i + 1) * (i + 1) }

st0 = a0.to_st_sum
st1 = a1.to_st_sum
st2 = a2.to_st_sum

q.times do
  cmd, x, y = gets.to_s.split.map(&.to_i64) + [0_i64]

  case cmd
  when 1
    i = x - 1
    y = y.to_m
    st0[i] = y
    st1[i] = y * x
    st2[i] = y * x * x
  when 2
    d0 = st0[...x] * (x + 1) * (x + 2) // 2
    d1 = st1[...x] * (x * 2 + 3) // 2
    d2 = st2[...x] // 2
    ans = d0 - d1 + d2
    pp ans
  end
end
