require "crystal/matrix"

n = gets.to_s.to_i64
m = Matrix.new([
  [1_i64, 1_i64],
  [1_i64, 0_i64],
])
ans = m ** n
pp ans[0]
