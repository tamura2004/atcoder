# g(i, j)が最小になる(i,j)を求める
def g(i, j)
  (100 - i) % 6 * (20 - j) % 7
end

pp Array.product((0..7).to_a, (0..7).to_a)
