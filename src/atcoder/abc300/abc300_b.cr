h, w = gets.to_s.split.map(&.to_i64)
a = Array.new(h){gets.to_s}
b = Array.new(h){gets.to_s}

h.times do |dy|
  w.times do |dx|
    ans = h.times.all? do |y|
      w.times.all? do |x|
        a[y][x] == b[(y+dy)%h][(x+dx)%w]
      end
    end
    quit :Yes if ans
  end
end
puts :No
