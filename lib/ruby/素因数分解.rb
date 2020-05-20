# 素因数分解
require "prime"

N,P = gets.split.map &:to_i
ans = 1
Prime.prime_division(P).each do |p,n|
  ans *= p if N <= n
end

puts ans

# nの約数の個数
def div_num(n)
  Prime.prime_division(n)
    .map(&:last)
    .map(&:succ)
    .inject(1,:*)
end

# 約数列挙
def divisions(n)
  1.upto(n) do |i|
    break if i*i > n
    if n % i == 0
      yield i
      yield n/i if i != n/i # 平方数の場合
    end
  end
end