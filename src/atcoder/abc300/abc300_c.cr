# シフトして連続列を数える
# 縦２倍
h, w = gets.to_s.split.map(&.to_i64)
a = Array.new(h){gets.to_s}

b = Array.new(h+w) do
  Array.new(w, '.')
end

h.times do |y|
  w.times do |x|
    b[y+x][x] = a[y][x]
  end
end

ans = Array.new(Math.min(h,w), 0_i64)

b.each do |row|
  row.chunk(&.itself).each do |ty,arr|
    if ty == '#'
      i = arr.size // 2
      if i > 0
        ans[i-1] += 1
      end
    end
  end
end

puts ans.join(" ")
