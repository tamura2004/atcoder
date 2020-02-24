# 素因数分解
require "prime"

N,P = gets.split.map &:to_i
ans = 1
Prime.prime_division(P).each do |p,n|
  ans *= p if N <= n
end

puts ans


