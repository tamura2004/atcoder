class Int64Grid
  getter h : Int32
  getter w : Int32
  getter dot : Array(Array(Int64))
  
  getter left : Array(Int64)
  getter top : Array(Int64)
  getter right : Array(Int64)
  getter bottom : Array(Int64)

  def initialize(@h, @w)
    @dot = (0...h).map do |y|
      (0...w).map do |x|
        1_i64 << ix(y, x)
      end
    end

    @left = (0..w).map do |i|
      g = 0_i64
      h.times do |y|
        w.times do |x|
          g |= dot[y][x] if x < i
        end
      end
      g
    end

    @top = left.map { |g| rot90(g) }
    @right = top.map { |g| rot90(g) }
    @bottom = right.map { |g| rot90(g) }
  end

  def v_fill(g)
    (h - 1).times do
      g |= g << w
    end
    g
  end

  def to_2d_array(g)
    (0...h).map do |y|
      (0...w).map do |x|
        g.bit ix(y, x)
      end
    end
  end

  def from_2d_array(a)
    g = 0_i64
    h.times do |y|
      w.times do |x|
        g |= dot[y][x] if a[y][x] == 1
      end
    end
    g
  end

  def rot90(g)
    from_2d_array to_2d_array(g).transpose.map(&.reverse)
  end

  def move_up(k, g)
    g >> k * w & ~bottom[k]
  end

  def move_down(k, g)
    g << k * w
  end

  def move_left(k, g)
    g >> k & ~right[k]
  end

  def move_right(k, g)
    g << k & ~left[k]
  end

  def debug(g)
    puts "==DEBUG=="
    puts g.to_s(2)
    puts to_2d_array(g).map(&.join(' ')).join("\n")
  end

  def ix(y, x)
    y * w + x
  end

  def outside?(y, x)
    y < 0 || h <= y || x < 0 || w <= x
  end
end
