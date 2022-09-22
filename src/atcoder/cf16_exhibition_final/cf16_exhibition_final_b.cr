require "crystal/complex"

a, b, c = Array.new(3) do
  C.read
end

# 面積
s = (a - b).cross(c - b).abs / 2

# s = (ab+bc+ca)r//2
# r = 2s//(ab+bc+ca)
ab = (a - b).abs
bc = (b - c).abs
ca = (c - a).abs
r = s * 2 / (ab + bc + ca)

maxi = [ab,bc,ca].max
# maxi * r == (r * 2 + maxi) * x
x = maxi * r / (r * 2 + maxi)

pp x
