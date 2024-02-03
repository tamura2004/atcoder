n = gets.to_s.to_i64
(0..n).each do |x|
  (0..n).each do |y|
    (0..n).each do |z|
      if x + y + z <= n
        puts [x, y, z].join(" ")
      end
    end
  end
end
