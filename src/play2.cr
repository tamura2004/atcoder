h = 35
w = 22
y = 3
x = 5

a = Array.new(h) { Array.new(w, '.') }
h.times do |i|
  w.times do |j|
    a[i][j] = '#' if ((i//y) + (j//x)).odd?
  end
end

puts a.map(&.join).join("\n")
