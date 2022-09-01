class Hoge
  getter a : Int32
  getter b : Int32
  getter c : Int32

  def initialize(@a, @b, @c)
  end
end

pp! Hoge.new(1,2,3)