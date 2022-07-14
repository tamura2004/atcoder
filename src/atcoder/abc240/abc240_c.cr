require "big"

n, x = gets.to_s.split.map(&.to_i64)
dp = 1.to_big_i

n.times do
  a, b = gets.to_s.split.map(&.to_i64)
  dp = (dp << a) | (dp << b)
end

puts dp.bit(x) == 1 ? :Yes : :No