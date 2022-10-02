n, q = gets.to_s.split.map(&.to_i)
a = Array.new(n) do |i|
  aa = gets.to_s.split.map(&.to_i64)
  l = aa.shift
  aa
end

q.times do
  s, t = gets.to_s.split.map(&.to_i.pred)
  pp a[s][t]
end
