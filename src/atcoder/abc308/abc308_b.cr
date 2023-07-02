n, m = gets.to_s.split.map(&.to_i64)
c = gets.to_s.split
d = gets.to_s.split
p = gets.to_s.split.map(&.to_i64)
p0 = p.shift
pr = d.zip(p).to_h

ans = c.sum do |color|
  if pr.has_key?(color)
    pr[color]
  else
    p0
  end
end

pp ans