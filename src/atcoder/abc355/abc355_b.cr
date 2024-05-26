n, m = gets.to_s.split.map(&.to_i64)
a = gets.to_s.split.map(&.to_i64).map{|i| {i, :a}}
b = gets.to_s.split.map(&.to_i64).map{|i| {i, :b}}

cnt = (a + b).sort.map(&.last).chunk(&.itself).select(&.first.== :a).map(&.last).map(&.size).max
yesno cnt >= 2