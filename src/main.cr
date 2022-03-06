require "crystal/modint9"

# 26進数として変換
def conv(a)
  ans = 0.to_m
  a.chars.map(&.ord.- 'A'.ord).each do |v|
    ans *= 26
    ans += v
  end
  ans + 1
end

def left(a)
  n = divceil(a.size, 2)
  a[0,n]
end

def right(a)
  n = divceil(a.size, 2)
  a[-n..]
end

t = gets.to_s.to_i
t.times do
  n = gets.to_s.to_i
  s = gets.to_s

  ans = conv(left(s))
  if right(s) < left(s).reverse
    ans -= 1
  end
  
  pp ans
end
