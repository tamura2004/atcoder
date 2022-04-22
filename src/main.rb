n, k = gets.split.map(&:to_i)
a = gets.split.map(&:to_i)
ans = a.bsearch_index do |x|
  x >= k
end || -1
pp ans
