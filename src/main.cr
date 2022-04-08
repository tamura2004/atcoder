require "crystal/indexable"
require "crystal/avl_tree"

n,m = gets.to_s.split.map(&.to_i64)
a = gets.to_s.split.map(&.to_i64).sort
b = gets.to_s.split.map(&.to_i64).sort
teacher = b.to_ordered_set

c = (0...n).map{|i|i.odd? ? a[i] : -a[i]}
d = c.map(&.-)

left = c.cs
right = d.csr

ans = Int64::MAX
n.times do |i|
  cnt = left[i] + right[i+1]

  teacher.lower(a[i]).try do |t|
    chmin ans, cnt + (t - a[i]).abs
  end

  teacher.upper(a[i]).try do |t|
    chmin ans, cnt + (t - a[i]).abs
  end
end

pp ans
