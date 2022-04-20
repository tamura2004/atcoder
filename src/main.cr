macro divceil(a, b)
  ((({{a}}) + ({{b}}) - 1) // ({{b}}))
end

require "big"
D = 10000.to_big_d
x,y,r = gets.to_s.split.map(&.to_big_d.*(D))
r2 = r ** 2

bottom = divceil(y - r, D)
top = (y + r) // D

ans = (bottom..top).sum do |i|
  ny = i * D

  left = ((x - r)..x).bsearch do |nx|
    (x - nx) ** 2 + (y - ny) ** 2 <= r2
  end.not_nil!

  right = (x..(x + r + 1)).bsearch do |nx|
    (x - nx) ** 2 + (y - ny) ** 2 > r2
  end.not_nil!

  divceil(right, D) - divceil(left, D)
end

pp ans

# divceilの理由
# light |          left |
#       V               V
# x  x     o  o  o  o      x  x
# x  x  o  o  o  o  o   x  x  x
