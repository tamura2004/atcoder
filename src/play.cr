# Σi<-1..N,abs(Ai-(b+i))
# = Σi<-1..N,abs((Ai-i) - b))
# bはメジアン

n = gets.to_s.to_i
a = gets.to_s.split.map(&.to_i64)
c = a.map_with_index do |v,i|
  v - i - 1
end.sort

b = c[n//2]
ans = c.sum do |v|
  (v - b).abs
end

pp ans