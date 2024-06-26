n = gets.to_s.to_i64
a = Array.new(n) { gets.to_s.chars.map(&.to_i64) }

ans = n.times.max_of do |y|
  n.times.max_of do |x|
    {-1, 0, 1}.max_of do |dx|
      {-1, 0, 1}.max_of do |dy|
        next 0 if dx.zero? && dy.zero?
        n.times.sum do |i|
          ny = (y + dy * i) % n
          nx = (x + dx * i) % n
          10_i64 ** i * a[ny][nx]
        end
      end
    end
  end
end

pp ans
