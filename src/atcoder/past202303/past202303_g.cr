h,w = gets.to_s.split.map(&.to_i64)
a = Array.new(h){gets.to_s.split.map(&.to_i64)}

ans = [] of Tuple(Int64,Int64)
h.pred.times do |y|
  w.times do |x|
    s, t = [a[y][x], a[y.succ][x]].sort
    ans << {s, t}
  end
end
h.times do |y|
  w.pred.times do |x|
    s, t = [a[y][x], a[y][x.succ]].sort
    ans << {s, t}
  end
end

puts ans.sort.map(&.join(" ")).join("\n")
