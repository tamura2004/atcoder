require "crystal/swag"
require "crystal/modint9"

record F, a : ModInt, b : ModInt do
  # f1 = a1x+b1, f2 = a2 x + b2
  # f1 + f2 = a2(a1 x + b1) + b2 = a2 a1 x + a2 b1 + b2
  def +(other : F) : F
    F.new(a * other.a, other.a * b + other.b)
  end

  def [](x : ModInt) : ModInt
    a * x + b
  end

  def self.zero
    F.new(ModInt.new(1), ModInt.new(0))
  end
end

sw = SWAG(F).new

q = gets.to_s.to_i
q.times do
  cmd, a, b = gets.to_s.split.map(&.to_i64) + [-1, -1]
  case cmd
  when 0
    sw.unshift(F.new(ModInt.new(a), ModInt.new(b)))
  when 1
    sw.push(F.new(ModInt.new(a), ModInt.new(b)))
  when 2
    sw.shift
  when 3
    sw.pop
  when 4
    pp sw.sum[a.to_m]
  end
end
