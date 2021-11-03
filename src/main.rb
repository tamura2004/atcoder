h, w = gets.split.map(&:to_i)
a = Array.new(h) { gets.split.map(&:to_i) }

yoko = a.map(&:sum)
tate = a.transpose.map(&:sum)

h.times do |y|
  ans = []
  w.times do |x|
    ans << yoko[y] + tate[x] - a[y][x]
  end
  puts ans.join(" ")
end
