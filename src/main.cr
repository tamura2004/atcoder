n = gets.to_s.to_i
s = [] of String
t = [] of Int32
n.times do
  i,j = gets.to_s.split
  s << i
  t << j.to_i
end
t << 0
x = gets.to_s
i = s.index(x).not_nil!
ans = t[(i+1)..n].sum
p ans
