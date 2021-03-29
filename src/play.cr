require "crystal/indexable"

n,k = gets.to_s.split.map(&.to_i64)
a = gets.to_s.split.map(&.to_i64).sort
b = gets.to_s.split.map(&.to_i64).sort

# 小さいほうからk番目 ->
# 「x以下の個数がk以上あるか」のxの最小値
c = -> (x : Int64) {
  cnt = a.sum do |v|
    b.count_less_or_equal(x//v)
  end
  k <= cnt
}

lo = 0_i64
hi = Int64::MAX
ans = (lo..hi).bsearch(&c)

pp ans