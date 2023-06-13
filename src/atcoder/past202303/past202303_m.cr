require "crystal/segment_tree"

n,m = gets.to_s.split.map(&.to_i64)
a = gets.to_s.split.map(&.to_i64)
b = gets.to_s.split.map(&.to_i64)

st = b.to_st_max

n.times do |i|
  j = (0...m).bsearch do |k|
    a[i] <= st[..k]
  end

  if j
    st[j] -= a[i]
  else
    puts "No"
    puts i.succ
    exit
  end
end

puts "Yes"
puts (0...m).map{|i| b[i] - st[i] }.join(" ")
