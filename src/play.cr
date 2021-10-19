n, k = gets.to_s.split.map(&.to_i)
a = gets.to_s.split.map(&.to_i.- 1)
s = Array.new(n) do
  gets.to_s
end

cnt = Array.new(n, false)
a.each do |i|
  cnt[i] = true
end

t = (0...n).map do |i|
  { s[i], cnt[i] }
end.sort_by(&.first)

lo = 0
while lo < n && !t[lo].last
  lo += 1
end

hi = lo
while hi < n && t[hi].last
  hi += 1
end

if (hi - lo) != k
  puts -1
  exit
end

head = t[lo].first
tail = t[hi-1].first
i = 0
max = Math.min head.size, tail.size
while i < max && head[i] == tail[i]
  i += 1
end
# pp! s
# pp! head
# pp! tail
puts head[0,i]
