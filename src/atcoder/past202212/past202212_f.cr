require "big"

n = gets.to_s.to_i64.to_big_i
a,b,c,d = gets.to_s.split.map(&.to_i64.to_big_i)
x = gets.to_s.gsub(/\./,"").to_i64.to_big_i

cnt = a + b * 2 + c * 3 + d * 4

INF = 1e18.to_i64.to_big_i

query = -> (y : BigInt) do
  (cnt + y) * 1000 <= x * (n + y)
end

ans = (0_i64.to_big_i..INF).bsearch(&query)
pp ans
