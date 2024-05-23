require "crystal/modint9"
require "crystal/lst"

record F, a : ModInt, b : ModInt do
  def +(other : F) : F
    F.new(a * other.a, b * other.a + other.b)
  end

  def *(other : ModInt) : ModInt
    other * a + b
  end
end

fxx = ->(x : ModInt, y : ModInt) { x + y }
fxa = ->(x : ModInt, a : F) { a * x }
faa = ->(a : F, b : F) { a + b }

n, q = gets.to_s.split.map(&.to_i64)
a = gets.to_s.split.map(&.to_i64.to_m)

st = LST(ModInt, F).new(a, fxx, fxa, faa)

q.times do
  cmd, l, r, a, b = gets.to_s.split.map(&.to_i64) + [0_i64, 0_i64, 0_i64]
  case cmd
  when 0
    st[l...r] = F.new(a.to_m, b.to_m)
  when 1
    puts st[l..l]
  end
end
