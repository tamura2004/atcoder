require "big"

n = gets.to_s.to_i64
a = 1.to_big_i

n.times do
  puts to_a(a).join(" ")
  a = a + (a << 64)
end

def to_a(a)
  ans = [] of BigInt
  while a > 0
    ans << a % (1.to_big_i << 64)
    a >>= 64
  end
  ans
end
