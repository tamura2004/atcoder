require "crystal/priority_queue"

n = gets.to_s.to_i64
a = gets.to_s.split.map(&.to_i64)
cnt = 0_i64
n.times do |i|
  while a[i].even?
    cnt += 1
    a[i] //= 2
  end
end

pq = a.to_pq_lesser
cnt.times do
  v = pq.pop
  pq << v * 3
end
ans = pq.pop
pp ans