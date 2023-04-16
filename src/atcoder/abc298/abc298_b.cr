n = gets.to_s.to_i
a = Array.new(n) do
  gets.to_s.split.map(&.to_i)
end
b = Array.new(n) do
  gets.to_s.split.map(&.to_i)
end

4.times do
  ans = n.times.all? do |y|
    n.times.all? do |x|
      a[y][x] == 0 || a[y][x] == b[y][x]
    end
  end

  quit :Yes if ans
  a = a.transpose.map(&.reverse)
end

puts :No
