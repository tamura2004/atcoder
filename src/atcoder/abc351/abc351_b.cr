n = gets.to_s.to_i64
a = Array.new(n) { gets.to_s }
b = Array.new(n) { gets.to_s }

n.times do |y|
  n.times do |x|
    if a[y][x] != b[y][x]
      puts "#{y.succ} #{x.succ}"
    end
  end
end
