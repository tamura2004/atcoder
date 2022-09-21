n = gets.to_s.to_i64

lo = 0_i64
hi = 2e9.to_i64
m = (lo..hi).bsearch{|x| n < x ** 2}.not_nil!

k = n - (m - 1)  ** 2

if k.zero?
  pp m - 1
elsif k <= m + 1
  pp m + 1 - k
else
  pp k - m + 1
end

# pp! [n,m,k]
# m^2 <= n < (m+1)^2