require "crystal/lis"

# 1 2 3 4 5 6 転倒数０，LIS = 6
# 1 2 4 3 5 6 転倒数１, LIS = 5
# 片方をソートした時が最大では
# 1 2 3 4 5 6
# 5 6 3 4 1 2

n = gets.to_s.to_i64
a = gets.to_s.split.map(&.to_i64)
b = gets.to_s.split.map(&.to_i64)

b = a.zip(b).sort.map(&.[1])
a.sort!

ans = LIS(Int64).new(b).solve + n
pp ans
