# 外接円の中心と半径の自乗
def circumcenter(a,b,c)
  x = (a-b)*c.abs2 + (b-c)*a.abs2 + (c-a)*b.abs2
  y = (a-b)*c.conj + (b-c)*a.conj + (c-a)*b.conj
  z = x / y
  r = (a-z).abs2
  [z,r]
end

# 二点の中心と中心からの距離の自乗
def bisector(a,b)
  z = (a+b) / 2
  r = ((a-b)/2).abs2
  [z,r]
end

# main
n = gets.to_i
a = Array.new(n){ gets.split.map &:to_f }.map{|b| Complex(*b)}
ans = [Float::INFINITY]
EPS = 1e-6
chmin = -> z,r { ans[0] = [ans[0], r].min if a.all?{|v| (v-z).abs2 <= r + EPS}}

# 2点を含む最小円を全探索
a.combination(2) do |s,t|
  z,r = bisector(s,t)
  chmin[z,r]
end

# 3点の外接円を全探索
a.combination(3) do |s,t,u|
  z,r = circumcenter(s,t,u)
  chmin[z,r]
end

puts Math.sqrt(ans[0])


