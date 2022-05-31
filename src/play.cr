class Hoge
  getter a : Int32

  def initialize(@a)
  end
end

class Fuga < Hoge
  getter b : Int32

  def initialize(@b)
    super(20)
  end
end

f = Fuga.new(10)
pp f