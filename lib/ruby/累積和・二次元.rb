h,w = gets.split.map &:to_i
a = Array.new(h) { gets.chomp.chars.map &:to_i }
cs = Array.new(h+1) { Array.new(w+1) { 0 } }

h.times do |y|
  w.times do |x|
    cs[y+1][x+1] = cs[y][x+1] - cs[y][x] + cs[y+1][x] + a[y][x]
  end
end

# [(top,left),(bottom,right)),cs
def rect(top,left,bottom,right,cs)
  cs[bottom][right] - cs[bottom][left] - cs[top][right] + cs[top][left]
end

puts h+w