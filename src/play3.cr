class Array(T)
  def buffer
    @buffer
  end
end

struct Hoge
  property v : Int32

  def initialize(@v)
  end

  def v=(v)
    @v = v
  end
end

h = Hoge.new(10)
a = [h]

a.buffer.value.v = 20
pp a.buffer.value.v
