m = gets.to_s.to_i64
d = gets.to_s.split.map(&.to_i64)

k = (d.sum + 1) // 2
m.times do |i|
  if k <= d[i]
    quit "#{i + 1} #{k}"
  else
    k -= d[i]
  end
end
