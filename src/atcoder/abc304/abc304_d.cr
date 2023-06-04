w, h = gets.to_s.split.map(&.to_i64)
n = gets.to_s.to_i64
p = Array.new(n) do
  x, y = gets.to_s.split.map(&.to_i64)
  {x, y}
end

an = gets.to_s.to_i64
a = gets.to_s.split.map(&.to_i64)
a << w
bn = gets.to_s.to_i64
b = gets.to_s.split.map(&.to_i64)
b << h

cnt = Hash(Tuple(Int32,Int32),Int64).new(0_i64)
n.times do |i|
  x = a.bsearch_index do |v|
    p[i][0] < v
  end.not_nil!
  y = b.bsearch_index do |v|
    p[i][1] < v
  end.not_nil!
  cnt[{x,y}] += 1
end

if cnt.keys.size < (an + 1) * (bn + 1)
  puts "0 #{cnt.values.max}"
else
  puts "#{cnt.values.min} #{cnt.values.max}"
end
