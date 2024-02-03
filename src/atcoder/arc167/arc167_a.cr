n, m = gets.to_s.split.map(&.to_i64)
a = gets.to_s.split.map(&.to_i64).sort

b = a.first(n - m).reverse + [0_i64] * (m * 2 - n)
c = a.last(m)

pp b.zip(c).map(&.sum.** 2).sum

