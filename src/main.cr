def solve
  h,w,a,b = gets.to_s.split.map(&.to_i64)
  return false if a > w // 2
  return false if b > h // 2

  h.times do |y|
    w.times do |x|
      print (x < a) ^ (y < b) ? '0' : '1'
    end
    puts
  end
  true
end

puts "No" unless solve