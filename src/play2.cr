n = gets.to_s.to_i
a = gets.to_s.split.map(&.to_i)
ans = [] of Int32
(0...n-1).each do |i|
  (i...n).each do |j|
    ans << a[i..j].sum.abs
  end
end
pp ans.sort