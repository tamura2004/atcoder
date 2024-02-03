# 二分探索で解く
# 判定問題
# kを最小値とする操作が可能か
# kより小さいAiについては、divceil(k - Ai, x)回操作する必要がある = need
# kより大きいAiについて、(Ai - k) // y回操作できる = can
# need <= canならtrue

require "crystal/range"

def query(k, a, x, y)
  need = a.sum do |v|
    divceil(Math.max(0_i64, k - v), x)
  end

  can = a.sum do |v|
    Math.max(0_i64, v - k) // y
  end

  need <= can
end

n, x, y = gets.to_s.split.map(&.to_i64)
a = gets.to_s.split.map(&.to_i64)

lo = 0_i64
hi = 1e9.to_i64
ans = (lo..hi).reverse_bsearch do |k|
  query(k, a, x, y)
end

pp ans
