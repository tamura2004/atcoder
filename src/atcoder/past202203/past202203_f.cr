h,w,n = gets.to_s.split.map(&.to_i)
a = Array.new(h) { gets.to_s.split.map(&.to_i.pred) }
c = gets.to_s.split.map(&.to_i)

ans1 = h.times.all? do |y|
  (w-1).times.all? do |x|
    a[y][x] == a[y][x+1] || c[a[y][x]] != c[a[y][x+1]]
  end
end

ans2 = (h-1).times.all? do |y|
  w.times.all? do |x|
    a[y][x] == a[y+1][x] || c[a[y][x]] != c[a[y+1][x]]
  end
end

ans = ans1 && ans2
puts ans ? "Yes" : "No"