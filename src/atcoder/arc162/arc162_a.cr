t = gets.to_s.to_i64
t.times do
  n = gets.to_s.to_i64
  a = gets.to_s.split.map(&.to_i.pred)

  ans = n.times.count do |i|
    n.times.none? do |j|
      i < j && a[i] > a[j]
    end
  end

  pp ans
end
