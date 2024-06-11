n, m = gets.to_s.split.map(&.to_i64)
a = gets.to_s.split.map(&.to_i64)
cnt = Array.new(m, 0)
x = Array.new(n) do
  b = gets.to_s.split.map(&.to_i64)
  m.times do |i|
    cnt[i] += b[i]
  end
end

yesno (0...m).all? { |i| cnt[i] >= a[i] }
