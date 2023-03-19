n, m = gets.to_s.split.map(&.to_i64)
a = gets.to_s.split.map(&.to_i64)
b = gets.to_s.split.map(&.to_i64)

cnt = (a.zip(0..) + b.zip(n..)).sort.zip(0..).sort_by(&.first.last)
puts cnt[0...n].map(&.last.succ).join(" ")
puts cnt[n..].map(&.last.succ).join(" ")