require "crystal/st"

record ModInt, v : UInt128 do
  MOD = 1_u128 << 61 - 1
  def +(b); ModInt.new((v + b.to_u128 % MOD) % MOD); end
  def -(b); ModInt.new((v + MOD - b.to_u128 % MOD) % MOD); end
  def *(b); ModInt.new((v * (b.to_u128 % MOD)) % MOD); end
  def self.zero; new(0); end
  def to_u128; v; end
end

struct Int
  def to_m
    ModInt.new(to_u128)
  end
end

POW = [1.to_m]
1_000_001.times do
  POW << POW[-1] * (10 ** 9 + 7)
end

alias X = Tuple(ModInt,Int32)
fxx = Proc(X,X,X).new do |(x, a), (y, b)|
  X.new(x * POW[b] + y, a + b)
end

n, q = gets.to_s.split.map(&.to_i64)
s = gets.to_s.chars.map(&.ord.to_m).zip([1] * n)
r = s.reverse

st = ST(X).new(s, fxx)
rt = ST(X).new(r, fxx)

q.times do |i|
  cmd, a, b = gets.to_s.split
  case cmd
  when "1"
    x = a.to_i.pred
    v = X.new(b[0].ord.to_m, 1)
    st[x] = v
    rt[n-1-x] = v
  when "2"
    l = a.to_i.pred
    r = b.to_i.pred
    if st[l..r] == rt[(n-1-r)..(n-1-l)]
      puts "Yes"
    else
      puts "No"
    end
  end
end
