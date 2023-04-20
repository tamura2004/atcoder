# 連続するTの長さの半分切り捨ての合計

h, w = gets.to_s.split.map(&.to_i64)
a = Array.new(h) do
  gets.to_s.chars
end

h.times do |y|
  (w-1).times do |x|
    if a[y][x] == 'T' && a[y][x+1] == 'T'
      a[y][x] = 'P'
      a[y][x+1] = 'C'
    end
  end
end

h.times do |y|
  puts a[y].join
end
