n, m = gets.to_s.split.map(&.to_i)
a = Array.new(m) do
  b = gets.to_s.split.map(&.to_i.pred)
  b.shift
  b.to_set
end

ans = n.times.all? do |i|
  n.times.all? do |j|
    next true if i == j
    m.times.any? do |k|
      i.in?(a[k]) && j.in?(a[k])
    end
  end
end

yesno ans
