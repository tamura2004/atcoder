n = gets.to_s.to_i
ans = [] of Tuple(Int32,Int32)
left = {} of Tuple(Int32,Int32) => Int32
right = {} of Tuple(Int32,Int32) => Int32
k = 0
while (1<<k) <= n
  n.times do |lo|
    hi = lo + (1<<k) - 1
    break if n <= hi
    left[{lo,k}] = ans.size
    right[{hi,k}] = ans.size
    ans << {lo, hi}
  end
  k += 1
end

puts ans.size
ans.each do |lo,hi|
  puts "#{lo+1} #{hi+1}"
end
STDOUT.flush

q = gets.to_s.to_i64
q.times do
  l, r = gets.to_s.split.map(&.to_i.pred)
  k = Math.ilogb((l..r).size)
  a = left[{l,k}]
  b = right[{r,k}]
  puts "#{a+1} #{b+1}"
  STDOUT.flush
end



