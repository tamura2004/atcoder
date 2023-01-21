require "crystal/number_theory/ext_gcd"

# # x = 3 (mod 6)
# # x = 1 (mod 4) # => x = 9 (mod 12)
# pp crt(1,2,1,3) #=> {9, 12}
# pp crt(1,6,3,5)



primes = [2, 3, 25, 7, 11, 13, 17, 19, 23].map(&.to_i64)
pp primes.sum
pp primes.product
pp primes.product.to_s
pp primes.product.to_s.size
exit

primes = [4, 5, 7, 9, 11, 13, 17, 19, 23].map(&.to_i64)
puts primes.sum
STDOUT.flush
a = Array.new(primes.sum, 0)

i = 0
primes.each do |p|
  p.times do |j|
    a[i + j] = i + j + 2
  end
  a[i + p - 1] = i + 1
  i += p
end

puts a.join(" ")
STDOUT.flush

# n = 4
# b = a.dup
# 100.times do |i|
#   j = i
#   n.times do
#     j = a[j] - 1
#   end
#   b[i] = j + 1
# end

b = gets.to_s.split.map(&.to_i64)

m = [] of Int64
i = 0
primes.each do |p|
  m << (b[i] - i - 1).to_i64
  i += p
end

# pp! n
# pp! a.first(5)
# pp! b.first(5)
# pp! m

ans, mod = crt(m[0], primes[0].to_i64, m[1], primes[1].to_i64).not_nil!
primes.each_with_index do |p, i|
  next if i <= 1
  ans, mod = crt(m[i], p, ans, mod).not_nil!
end

# pp! ans

if ans.zero?
  puts primes.map(&.to_i64).product
else
  puts ans
end
STDOUT.flush
