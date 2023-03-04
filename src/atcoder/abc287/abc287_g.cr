require "crystal/coodinate_compress_liner"
require "crystal/segment_tree"

n = gets.to_s.to_i64
a, b = Array.new(n){gets.to_s.split.map(&.to_i64)}.transpose

q = gets.to_s.to_i64
queries = Array.new(q){gets.to_s.split.map(&.to_i64)}

cc = CCL.new(a.map(&.-))
queries.each do |query|
  if query[0] == 1
    cc << -query[2]
  end
end
cc.commit!

cnt = cc.size.to_st_sum
tot = cc.size.to_st_sum

n.times do |i|
  cnt[cc.ix[-a[i]]] += b[i]
  tot[cc.ix[-a[i]]] += a[i] * b[i]
end

q.times do |i|
  cmd, x, y = queries[i] + [-1i64]
  case cmd
  when 1
    i = x.pred.to_i
    cnt[cc.ix[-a[i]]] -= b[i]
    tot[cc.ix[-a[i]]] -= a[i] * b[i]
    a[i] = y
    cnt[cc.ix[-a[i]]] += b[i]
    tot[cc.ix[-a[i]]] += a[i] * b[i]
  when 2
    i = x.pred
    diff = y - b[i]
    b[i] = y
    cnt[cc.ix[-a[i]]] += diff
    tot[cc.ix[-a[i]]] += a[i] * diff
  when 3
    # 少なくともi番目まで選ぶ必要がある
    i = cnt.bsearch(x)
    # i番目まで選んでも数が足らない
    if cnt[..i] < x
      puts -1
    else
      # i番目をいくつ選ぶ必要があるか
      j = x - cnt[...i]
      ans = tot[...i] - cc.val[i] * j
      pp ans
    end
  end
end

  