# 今までx人、y組が座れているとき
# a[i] == 1なら常に座れる
# a[i] == 2なら、
# divceil(L - x, y + 1) >= 2で座れる

# n, l = gets.to_s.split.map(&.to_i64)
# a = gets.to_s.split.map(&.to_i64)

require "crystal/priority_queue"

100.times do
  n = 10
  a = Array.new(n) { rand < 0.5 ? 1 : 2 }
  l = a.sum.to_i64

  if got(n,l,a) != want(n,l,a)
    pp! n
    pp! a
    pp! l
    pp! got(n,l,a)
    pp! want(n,l,a)
  end
end

# 正しい
# なるべく1を残す
def want(n, l, a)
  x = y = 0_i64
  n.times do |i|
    return "No" if a[i] == 2 && divceil(l - x, y + 1) < 2
    x += a[i]
    y += 1
  end
  return "Yes"
end

# 駄目
# 常に真ん中に座る
# 反例：7 14
# 2 2 2 2 2 2 2
def got(n,l,a)
  pq = PriorityQueue(Int64).greater
  pq << l

  n.times do |i|
    return "No" if pq.size.zero?
    l = pq.pop
    return "No" if l < a[i]
    l -= a[i]
    lo = l // 2
    hi = divceil(l, 2)
    pq << lo if lo > 0
    pq << hi if hi > 0
  end

  return "Yes"
end
