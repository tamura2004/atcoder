h,w = gets.to_s.split.map(&.to_i64)
s = Array.new(h){gets.to_s}
name = "snuke"

h.times do |y|
  w.times do |x|
    [-1,0,1].each do |dy|
      [-1,0,1].each do |dx|
        next if dy.zero? && dx.zero?
        ans = 5.times.all? do |i|
          yy = y + dy * i
          xx = x + dx * i
          if 0 <= yy < h && 0 <= xx < w
            name[i] == s[yy][xx]
          else
            false
          end
        end

        if ans
          5.times do |i|
            puts "#{y + i * dy + 1} #{x + dx * i + 1}"
          end
          exit
        end
      end
    end
  end
end
