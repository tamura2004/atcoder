n,x,y,z = gets.to_s.split.map(&.to_i64)
a = gets.to_s.split.map(&.to_i64)
b = gets.to_s.split.map(&.to_i64)

c = (0...n).map{|i| a[i]+b[i]}

ss = (0i64...n).map do |i|
  {i, a[i], b[i], c[i]}
end

# 数学の点が高いほうからx人選ぶ
ss.sort_by!{|s|{s[1], -s[0]}}

ans = [] of Tuple(Int64,Int64,Int64,Int64)

x.times do
  ans << ss.pop
end

# 英語の点が高いほうからy人選ぶ
ss.sort_by!{|s|{s[2], -s[0]}}

y.times do
  ans << ss.pop
end

# 合計からz忍
ss.sort_by!{|s|{s[3], -s[0]}}

z.times do
  ans << ss.pop
end

ans.sort!
ans.map(&.first).each do |i|
  puts i + 1
end
