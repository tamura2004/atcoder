class Hoge
  getter a : Int32
  getter b : Int64

  def initialize(@a,@b)
  end

  def [](i)
    case i
    when 0 then a
    when 1 then b
    else raise IndexError.new
    end
  end
end



t = Hoge.new(1,2i64)
a,b = t

pp t.class
pp a.class
pp b.class