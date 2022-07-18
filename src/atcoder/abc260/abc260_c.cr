require "crystal/matrix"

n, x, y = gets.to_s.split.map(&.to_i64)
m = Matrix(Int64).new(
  [
    [x+1,1_i64],
    [x*y,y]
  ]
)

ans = m ** (n - 1) * [1_i64, 0_i64]
pp ans.last