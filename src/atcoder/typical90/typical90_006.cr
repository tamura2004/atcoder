# 削除可能PQ
require "crystal/priority_queue"

n, k = gets.to_s.split.map(&.to_i64)
a = gets.to_s.chars.zip(0..)
pq = PQ(Tuple(Char, Int32)).lesser

lo = 0
ans = [] of Char
n.times do |i|
  pq << a[i]
  next if i < n - k

  while pq.size > 0 && pq[0][1] < lo
    pq.pop
  end

  v, lo = pq.pop
  ans << v
  lo += 1
end

puts ans.join
