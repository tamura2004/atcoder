n = gets.to_i
a = 1

def to_a(a)
  ans = []
  while a > 0
    ans << a % (1 << 64)
    a >>= 64
  end
  ans
end

n.times do
  puts to_a(a).join(" ")
  a = a + (a << 64)
end
