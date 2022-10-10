n, m = gets.to_s.split.map(&.to_i)
a = Array.new(m) do
  b = gets.to_s.split.map(&.to_i.pred)
  b.shift
  b.to_set
end

n.times do |i|
  n.times do |j|
    next if i == j
    flag = m.times.none? do |k|
      i.in?(a[k]) && j.in?(a[k])
    end
    quit "No" if flag
  end
end

puts "Yes"
