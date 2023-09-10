# 場合の数 / 9!

c = Array.new(3) { gets.to_s.split.map(&.to_i) }
cnt = 0_f64

(0...9).to_a.each_permutation do |ord|
  cnt += ->{
    tate = Array.new(3, -1)
    yoko = Array.new(3, -1)
    ur = -1
    ul = -1

    ord.each do |i|
      y, x = i.divmod(3)

      if tate[y] != -1
        if tate[y] == c[y][x]
          return 0
        else
          tate[y] = -1
        end
      else
        tate[y] = c[y][x]
      end

      if yoko[x] != -1
        if yoko[x] == c[y][x]
          return 0
        else
          yoko[x] = -1
        end
      else
        yoko[x] = c[y][x]
      end

      if y == x
        if ur != -1
          if ur == c[y][x]
            return 0
          else
            ur = -1
          end
        else
          ur = c[y][x]
        end
      end

      if y == 2 - x
        if ul != -1
          if ul == c[y][x]
            return 0
          else
            ul = -1
          end
        else
          ul = c[y][x]
        end
      end
    end
    return 1
  }.call
end

(2..9).each do |i|
  cnt /= i
end

pp cnt
