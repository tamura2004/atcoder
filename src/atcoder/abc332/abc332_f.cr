# 遅延セグ木
# 作用を行列を用いて次のように定める
#
# 確率pでaに置き換わる
# | 1-p pa |
# | 0   1  |
#
# または、そのままである確率p, 置き換わる期待値eとして
# (p, e)として持つ
#
# 作用順に右から左の行列乗算になる（直感と逆）ことに注意
#
# この場合、演算は、右側が後から適用したものとして
# (p, e) * (p', e') = (pp', ep' + e')
#
# 要素の値がxのとき、列ベクトルで持つ
# | x |
# | 1 |
#
# または値xを持ち、作用(p, e)との演算を
# px + eで定める

require "crystal/modint9"
require "crystal/lst"

record A, p : ModInt, e : ModInt do
  def *(other : self)
    A.new(p * other.p, other.p * e + other.e)
  end
end

alias X = ModInt

fxx = ->(x : X, y : X) { y }
faa = ->(a : A, b : A) { a * b }
fxa = ->(x : X, a : A) { a.p * x + a.e }

n, m = gets.to_s.split.map(&.to_i64)
a = gets.to_s.split.map(&.to_i64.to_m)
st = LST(X, A).new(a, fxx, fxa, faa)

m.times do
  lo, hi, x = gets.to_s.split.map(&.to_i64)
  lo -= 1
  hi -= 1
  p = 1.to_m // (lo..hi).size.to_i64
  st[lo..hi] = A.new(1.to_m - p, p * x)
end

ans = (0...n).map do |i|
  st[i..i]
end

puts ans.join(" ")