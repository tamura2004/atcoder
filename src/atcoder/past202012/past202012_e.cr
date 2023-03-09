h, w = gets.to_s.split.map(&.to_i)
l = Math.max(h, w)

s = Array.new(h) do
  gets.to_s.chars.map(&.==('#').to_unsafe)
end

t = Array.new(h) do
  gets.to_s.chars.map(&.==('#').to_unsafe)
end

u = Hash(Tuple(Int32,Int32),Int32).new(1)
h.times do |y|
  w.times do |x|
    if s[y][x] == 0
      u[{y,x}] = 0
    end
  end
end

hh = h
ww = w

(-l..h+l).each do |y|
  (-l..w+l).each do |x|
    4.times do |i|
      cnt = (0...hh).map do |yy|
        (0...ww).map do |xx|
          t[yy][xx] + u[{yy+y,xx+x}]
        end
      end

      if cnt.flatten.all?(&.<= 1)
        puts "Yes"
        exit
      end

      t = t.transpose.reverse
      hh, ww = ww, hh

    end
  end
end

puts "No"
