n, m = gets.to_s.split.map(&.to_i)
a = Array.new(m) do
  gets
  gets.to_s.split.map(&.to_i.pred).map do |i|
    1 << i
  end.sum
end

ans = (1<<m).times.count do |s|
  cnt = 0
  m.times do |i|
    if s.bit(i) == 1
      cnt |= a[i]
    end
  end
  cnt == (1<<n) - 1
end

pp ans