require "crystal/priority_queue"

n = gets.to_s.to_i64
a = gets.to_s.split.map(&.to_i64).tally
pq = PQ(Int64).lesser
pq << 1_i64

a.keys.sort.reverse_each do |v|
  size = a[v]
  quit "No" if pq.size < size

  tmp = [] of Int64
  size.times do
    nv = pq.pop
    f(nv, n, tmp)
  end

  tmp.each do |v|
    pq << v
  end
end

puts "Yes"

def f(v : T, n, ans : Array(T)) forall T
  maxi = 2 ** n
  while v < maxi
    v *= 2
    ans << v + 1
  end
end
