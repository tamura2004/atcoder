a = Array.new(9) do
  gets.to_s.split.map(&.to_i64)
end

2.times do
  cnt = a.any? do |row|
    row.to_set.size != 9
  end
  quit :No if cnt
  a = a.transpose
end

3.times do |y|
  3.times do |x|
    set = Set(Int64).new
    3.times do |i|
      3.times do |j|
        set << a[y*3+i][x*3+j]
      end
    end

    quit :No if set.size != 9
  end
end

puts :Yes

