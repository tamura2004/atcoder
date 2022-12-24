require "crystal/bit_array"

hh, ww, n, h, w = gets.to_s.split.map(&.to_i64)
a = Array.new(hh) { gets.to_s.split.map(&.to_i64) }

all = [] of Array(BitArray)

4.times do
  row = BitArray.new
  col = [] of BitArray
  (0...hh).each do |y|
    col << row
    row += a[y].to_bit_array
  end
  col << row
  all << col
  hh, ww = ww, hh
  a = a.transpose.reverse
end

(hh - h + 1).times do |y|
  ans = [] of Int32
  (ww - w + 1).times do |x|
    ans << (all[0][y] + all[3][x] + all[2][hh - y - h] + all[1][ww - x - w]).size
  end
  puts ans.join(" ")
end
