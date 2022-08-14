# bit
# pp bit_to_index(0b00010101,8) => [0,2,4]
def bit_to_index(mask, n)
  ans = [] of Int32
  n.times do |i|
    if mask.bit(i) == 1
      ans << i
    end
  end
  ans
end

h1, w1 = gets.to_s.split.map(&.to_i64)
a = Array.new(h1){gets.to_s.split.map(&.to_i64)}

h2, w2 = gets.to_s.split.map(&.to_i64)
b = Array.new(h2){gets.to_s.split.map(&.to_i64)}

# tate, yoko = bit mask
(1<<h1).times do |tate|
  next if tate.popcount != h2

  (1<<w1).times do |yoko|
    next if yoko.popcount != w2

    
    flag = true
    bit_to_index(tate, 10).each_with_index do |y2,y1|
      bit_to_index(yoko, 10).each_with_index do |x2,x1|
        if a[y2][x2] != b[y1][x1]
          flag = false
        end
      end
    end

    quit "Yes" if flag
  end  
end  

puts "No"

