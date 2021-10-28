struct Problem
  DIR = [{0, 0}, {0, 1}, {1, 0}, {1, 1}]

  getter h : Int32
  getter w : Int32
  getter q : Int32
  getter s : Array(Array(Int32))
  getter rc : Array(Tuple(Int32,Int32))
  getter wolf : Set(Tuple(Int32,Int32))

  def initialize
    @h,@w,@q = gets.to_s.split.map(&.to_i)
    @s = Array.new(h) { gets.to_s.chars.map{|c| c == '#' ? 1 : 0 } }
    @rc = Array.new(q-1) { Tuple(Int32,Int32).from gets.to_s.split.map(&.to_i.- 1) }
    @wolf = Set(Tuple(Int32,Int32)).new
  end

  def outside?(y,x)
    y < 0 || h <= y || x < 0 || w <= x
  end

  def subsquare_sum(y,x)
    DIR.sum do |dy,dx|
      ny = y + dy
      nx = x + dx
      return nil if outside?(ny,nx)
      s[ny][nx]
    end
  end

  def rec_wolf
    (h-1).times do |y|
      (w-1).times do |x|
        wolf << {y,x} if subsquare_sum(y,x).try &.odd?
      end
    end
  end

  def solve
    show_all if h == 1 || w == 1
    rec_wolf
    show_none if wolf.size > 4

    puts valid? ? "Yes" : "No"
    
    (q-1).times do |i|
      sy, sx = rc[i]
      [{sy-1,sx-1},{sy-1,sx},{sy,sx-1},{sy,sx}].each do |y,x|
        if parity = subsquare_sum(y,x)
          if parity.odd?
            wolf.delete({y,x})
          else
            wolf << {y,x}
          end
        end
      end
      s[sy][sx] = 1 - s[sy][sx] 
      puts valid? ? "Yes" : "No"
    end
  end

  def valid?
    case wolf.size
    when 0 then true
    when 1 then true
    when 2
      rows_num == 1 || cols_num == 1
    when 3 then false
    when 4
      rows_num == 2 && cols_num == 2
    else false
    end
  end

  def rows_num
    wolf.to_a.map(&.first).uniq.size
  end
  
  def cols_num
    wolf.to_a.map(&.last).uniq.size
  end

  def show_all
    (q+1).times do
      puts "Yes"
    end
    exit
  end
  
  def show_none
    (q+1).times do
      puts "No"
    end
    exit
  end

  def debug
    rec_wolf
    pp self
  end
end

Problem.new.solve








