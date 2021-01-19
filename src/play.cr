class Hoge(T)
  getter f : T, T -> T
  def initialize
    @f = -> (x : T, y : T) {
      yield x,y
    }
  end

  def add(x,y)
    f.call(x,y)
  end
end

hoge = Hoge(Int32).new{|a,b|a-b}
pp! hoge.add(10,5)
