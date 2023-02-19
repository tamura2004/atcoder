n, k = gets.to_s.split.map(&.to_i)
a = gets.to_s.split.map(&.to_i64).sort.uniq.first(k).zip(0..)

a.each do |i,j|
  if i != j
    quit j
  end
end

pp a.size

