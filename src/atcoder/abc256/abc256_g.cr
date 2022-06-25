require "crystal/modint9"
require "crystal/fact_table"
require "crystal/matrix"

n, d = gets.to_s.split.map(&.to_i64)

ans = (0i64..d + 1).sum do |x|
  m = Matrix(ModInt).new(2) do |i, j|
    (d - 1).c(x - i - j)
  end ** n
  
  m[0, 0] + m[1, 1]
end

pp ans
