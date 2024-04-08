# 全探索？
# 置き場所は101通り
# 101 ** 7 = 10 ^ 14 -> 無理
# 並べ替え 7! = 5040 * 128通り

n, h, w = gets.to_s.split.map(&.to_i64)
t = Array.new(n) do
  a, b = gets.to_s.split.map(&.to_i64)
  { a, b }
end

# pp! t

(0...n).to_a.each_permutation do |arr|
  (0..2).to_a.each_repeated_permutation(n) do |mask|
    # brd = Array.new(h) { Array.new(w, 0) }
    brd = Array.new(h, 0)
    dirty = false

    # arr = [0, 1, 2, 3, 4]
    # mask = [0, 1, 0, 2, 1]

    arr.each do |i|
      next if mask[i] == 0
      wi, hi = t[i]
      wi, hi = hi, wi if mask[i] == 1
      yi, xi = find_corner(brd, h, w)

      # pp! "---"
      # pp! [wi, hi]
      # pp! [xi, yi]
      # pp! yi + hi
      # pp! xi + wi

      next if yi == -1
      next unless yi + hi <= h
      next unless xi + wi <= w
      sub_mask = ((1<<wi)-1)<<xi
      hi.times do |yy|
        if brd[yi+yy] & sub_mask != 0
          dirty = true
        end
        brd[yi+yy] |= sub_mask
        break if dirty
      end
      break if dirty
    end

    
    # puts "----"
    # puts brd.map(&.join).join("\n")
    # exit

    if brd.all?(&.== ((1<<w)-1))
      quit :Yes
    end
  end
end
puts :No

def find_corner(brd, h, w)
  h.times do |y|
    w.times do |x|
      if brd[y].bit(x) == 0
        return ({y, x})
      end
    end
  end
  ({-1,-1})
end
