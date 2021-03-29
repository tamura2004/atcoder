# 平均最大化
require "crystal/bsearch"

n = 3
k = 2
wv = [{2,2},{5,3},{2,1}]

# 重量単位の価値の平均をx以上にできるとは
# Σi<-S,Vi / Σi<-S,Wi >= x
# Σi<-S,Vi - Wi*x >= 0
# 降順にソートして先頭からk個選ぶ
bs = BSearch(Float64).new do |x|
  b = wv.map{|w,v|v - w * x}.sort.reverse
  b[0,k].sum >= 0
end

puts bs.max_of(0.0_f64, 1000000.0_f64, 200)