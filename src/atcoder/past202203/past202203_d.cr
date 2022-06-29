t,n = gets.to_s.split.map(&.to_i64)
a = Array.new(n, 0_i64)

t.times do
  p = gets.to_s.split.map(&.to_i64)
  n.times do |i|
    chmax a[i], p[i]
  end

  pp a.sum
end