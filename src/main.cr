require "crystal/prime"
require "crystal/bit_set"
require "crystal/number_theory/ext_gcd"

n = gets.to_s.to_i64 * 2
a = n.prime_division #PrimeLarge(Int64).prime_division(n)
b = a.map { |k, v| k ** v }
m = a.size

ans = (1 << m).times.min_of do |s|
  x = s.elements.map(&.of b).product
  y = s.inv(m).elements.map(&.of b).product


  if cnt = crt(0, x, -1, y)
    next Int64::MAX if cnt[0].zero?
    cnt[0]
  else
    Int64::MAX
  end
end

pp ans
