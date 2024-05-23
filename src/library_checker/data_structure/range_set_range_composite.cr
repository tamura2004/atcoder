require "crystal/lst"
require "crystal/modint9"

record F, a : ModInt, b : ModInt do
  def +(other : F) : F
    F.new(a * other.a, other.a * b + other.b)
  end

  def self.zero
    F.new(1.to_m, 0.to_m)
  end

  def **(n : Int32) : F
    base = self
    ans = F.zero
    while n > 0
      if n.odd?
        ans += base
      end
      n //= 2
      base += base
    end
    ans
  end

  def [](x)
    a * x + b
  end
end

record X, f : F, cnt : Int32 do
  def self.zero
    X.new(F.zero, 1)
  end

  def +(other : X) : X
    X.new(f + other.f, cnt + other.cnt)
  end

  def *(other : F) : X
    X.new(other ** cnt, cnt)
  end
end

n, q = gets.to_s.split.map(&.to_i64)
values = Array.new(n) do
  a, b = gets.to_s.split.map(&.to_i64)
  X.new(F.new(a.to_m, b.to_m), 1)
end

st = LST(X, F).new(values)
q.times do
  cmd, l, r, c, d = gets.to_s.split.map(&.to_i64) + [0_i64]
  case cmd
  when 0
    st[l...r] = F.new(c.to_m, d.to_m)
  when 1
    puts st[l...r].f[c]
  end
end
