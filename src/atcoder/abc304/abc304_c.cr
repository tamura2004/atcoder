require "crystal/complex"
n, d = gets.to_s.split.map(&.to_i64)
dd = d ** 2
a = Array.new(n) do
  C.read
end

q = Deque.new([0_i64])
ans = Array.new(n, false)
while q.size > 0
  i = q.shift
  ans[i] = true
  n.times do |j|
    next if i == j
    next if ans[j]
    next if dd < (a[i] - a[j]).abs2 
    ans[j] = true
    q << j
  end
end

n.times do |i|
  puts ans[i] ? :Yes : :No
end
