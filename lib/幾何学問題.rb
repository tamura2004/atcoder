# ARC042B
# アリの高橋くんは凸多角形状の板の上にいます。 高橋くんは向いている方向にまっすぐ歩いていきますが、どの方向を向いているかはわかりません。 高橋くんは板の周囲にたどり着くと落ちてしまいます。 高橋くんの位置と板を構成する凸多角形の頂点の位置が与えられるので、高橋くんが板から落ちるまでに歩く最短の距離を求めてください。位置は全て２次元座標で与えられます。

def dist(a,b,c)
  return ((c-a)*((b-a).conj)/((b-a).abs)).imag.abs
end

o = Complex.rect(*gets.split.map(&:to_i))
n = gets.to_i
c = n.times.map do |i|
  Complex.rect(*gets.split.map(&:to_i))
end

ans = 1000
n.times do |i|
  j = (i + 1) % n
  d = dist(c[i],c[j],o)
  ans = d if ans > d
end
printf("%.12f\n", ans)
