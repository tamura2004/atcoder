# 最大値と最小値の絶対値の大小で場合分け
# １．最大値の絶対値が大きい(>0)
# 最大値の位置をmax_iとする
# v < 0にmax_iを足す＞全てゼロ以上になる
# iにi-1を足す

n = gets.to_s.to_i
a = gets.to_s.split.map(&.to_i64)
ans = [] of Tuple(Int32,Int32)

mini, maxi = a.minmax

if mini.abs <= maxi.abs
  i = a.index(maxi).not_nil!

  n.times do |j|
    if a[j] < 0
      ans << {i, j}
    end
  end

  (n-1).times do |i|
    ans << {i, i+1}
  end
else
  i = a.index(mini).not_nil!

  n.times do |j|
    if a[j] > 0
      ans << {i, j}
    end
  end

  (1...n).reverse_each do |i|
    ans << {i, i-1}
  end
end

puts ans.size
ans.each do |v,nv|
  puts "#{v+1} #{nv+1}"
end


