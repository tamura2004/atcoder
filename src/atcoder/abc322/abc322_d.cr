# 全探索
# 高々16個のタプルの配列
# クリップ：xの最小値とyの最小値で引く
# 反転：最大値から引いてクリップ
# 転置
require "crystal/poly"

pos = Array.new(3) do
  po = Poly.new
  4.times do |y|
    s = gets.to_s
    4.times do |x|
      if s[x] == '#'
        po << ({x, y})
      end
    end
  end
  po.clip
  po
end

quit "No" if pos.sum(&.a.size) != 16

goal = Set(Tuple(Int32, Int32)).new
4.times do |y|
  4.times do |x|
    goal << ({x, y})
  end
end

4.times do
  pos[0].rot90
  4.times do
    pos[1].rot90
    4.times do
      pos[2].rot90

      (5 - pos[0].w).times do |x1|
        (5 - pos[0].h).times do |y1|
          (5 - pos[1].w).times do |x2|
            (5 - pos[1].h).times do |y2|
              (5 - pos[2].w).times do |x3|
                (5 - pos[2].h).times do |y3|
                  p1 = pos[0].a.map(&.+({x1, y1})).to_set
                  p2 = pos[1].a.map(&.+({x2, y2})).to_set
                  p3 = pos[2].a.map(&.+({x3, y3})).to_set
                  if !p1.intersects?(p2) && !p2.intersects?(p3) && !p1.intersects?(p3) && (p1 | p2 | p3) == goal
                    quit "Yes"
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end
puts "No"
