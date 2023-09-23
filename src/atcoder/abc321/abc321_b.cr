# 全探索
n, x = gets.to_s.split.map(&.to_i64)
a = gets.to_s.split.map(&.to_i64)

(0i64..100i64).each do |y|
  b = (a + [y]).sort
  if b.sum - b.first - b.last >= x
    quit y
  end
end

puts -1

# lo = a.first
# mid = a[1..-2].sum
# hi = a.last

# if mid + lo == x
#   puts 0
# elsif mid + lo < x <= mid + hi
#   puts x - mid
# else
#   puts -1
# end
