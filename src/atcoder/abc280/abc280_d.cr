require "crystal/prime"

def root(n,p)
  ans = 0_i64
  while n.divisible_by?(p)
    ans += 1
    n //= p
  end
  ans
end

n = gets.to_s.to_i64
ans = 0_i64
n.prime_division.each do |p,q|
  num = p
  cnt = 1_i64
  while cnt < q
    num += p
    cnt += root(num, p)
  end
  chmax ans, num
end

puts ans
