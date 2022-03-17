require "crystal/indexable"

# ソート済の数列aに対し、積がx以下になるペアの個数
# 全部数えて、同値を引いて、半分
def count_product_pair(a, x)
  cnt = a.sum do |v|
    a.count_less_or_equal(x // v)
  end

  cnt -= a.count(&.**(2).<= x)
  cnt // 2
end

n, k = gets.to_s.split.map(&.to_i64)
a = gets.to_s.split.map(&.to_i64).sort

# n = 2e5.to_i64
# k = rand(1i64..n*(n-1)//2)
# a = Array.new(n) { rand(-1e9.to_i64..1e9.to_i64)}

m = a.select(&.< 0).map(&.* -1).sort
ms = m.size.to_i64
z = a.count(0).to_i64
p = a.select(&.> 0)
ps = p.size.to_i64

# f(i,j) = a[i]*a[j]の小さいほうからK番目を求めよ
# 小さいほうから4番目の値が2
# 小さいほうからk番目の値がx
# x以下の値がk個以上
# 1 1 2 2 2 3 4
#       ^
# 「x以下の個数がk個以上」のxに関する下界：単調性あるので二分探索
count = -> (x : Int64) do
  cnt = case
        when x == 0
          ms * ps + z * (ms + ps) + z * (z - 1) // 2
        when x < 0
          p.sum do |v|
            m.count_more_or_equal(divceil(-x,v))
          end
        else # x > 0
          now = ms * ps + z * (ms + ps) + z * (z - 1) // 2
          now += count_product_pair(p, x)
          now += count_product_pair(m, x)
          now
        end
  k <= cnt
end

hi = 2e18.to_i64
lo = -hi
ans = (lo..hi).bsearch(&count)

pp ans
