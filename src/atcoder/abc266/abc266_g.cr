require "crystal/modint9"
require "crystal/fact_table"

r, g, b, k = gets.to_s.split.map(&.to_i64)

# |rg|=k, |r|=r-k, |b|=bの並び順を先に決める
# 残るgは、|r|の後ろ以外ならどこでも配置できる、候補=b+k+1
# (b+k+1).h(g)
# ans = (r+b).c(b) * r.c(k) * (b+k+1).h(g-k)
# pp ans

# 別解
# 少なくともi個|RG|を含むを考える
# |RG|=i,|R|=r-i,|G|=g-i,|B|=bの並べ替えで求められる＝多項係数
# i > kのとき、iのうちどのk個がRGなのかを考えると、重複しない集合になる
# これをf(i)としたとき、丁度k個含む＝g(i)とすると
# g(i) = Σ j=k..min(r,g) (-1) ** (i-k) * f(i) * i.c(k)
def f(r,g,b,i)
  (r+g+b-i).c(r-i) * (g+b).c(g-i) * (b+i).c(i)
end

ans = 0.to_m
(k..Math.min(r,g)).each do |i|
  ans += f(r,g,b,i) * i.c(k) * (i-k).even?.to_unsafe.*(2).-(1)
end
pp ans
