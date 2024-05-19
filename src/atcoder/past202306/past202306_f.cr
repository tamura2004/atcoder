# 重複を除かない座標圧縮
n = gets.to_s.to_i64
a = gets.to_s.split.map(&.to_i64)

puts a.zip(0..).sort.map(&.last).zip(0..).sort.map(&.last.succ).join(" ")
