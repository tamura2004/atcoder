require "crystal/indexable"
require "crystal/range"

n, m, k = gets.to_s.split.map(&.to_i64)
s = gets.to_s
x = s.count("x").to_i64
cs = s.chars.map(&.==('x').to_unsafe.to_i64).cs

query = ->(i : Int64) do
  q, r = i.divmod(n)
  Math.min x * m, x * q + cs[r]
end

# pp! query.call(n*m + 1)
ans = (0_i64...n).max_of do |i|
  hi = (i..n*m).reverse_bsearch do |j|
    query.call(j) - query.call(i) <= k
  end.not_nil!
  hi - i
end
pp ans