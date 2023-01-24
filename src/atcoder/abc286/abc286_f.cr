require "crystal/number_theory/ext_gcd"

primes = [4, 5, 7, 9, 11, 13, 17, 19, 23].map(&.to_i64)
n = primes.sum
puts n
STDOUT.flush
a = Array.new(primes.sum, &.itself.succ)
cs = [0_i64]
primes.each {|prime| cs << cs[-1] + prime}
cs.each_cons_pair do |lo,hi|
  a[lo...hi] = a[lo...hi].rotate
end

puts a.join(" ")
STDOUT.flush

b = gets.to_s.split.map(&.to_i64)

m = [] of Int64
cs.each_cons_pair do |lo, hi|
  m << (b[lo] - lo - 1).to_i64
end

ans, mod = crt(m[0], primes[0].to_i64, m[1], primes[1].to_i64).not_nil!
primes.each_with_index do |p, i|
  next if i <= 1
  ans, mod = crt(m[i], p, ans, mod).not_nil!
end

puts ans
STDOUT.flush
