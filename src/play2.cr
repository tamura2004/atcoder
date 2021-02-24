alias X = Tuple(Int32,Int32)

struct X
  def f(y : self)
    self[0] + y[0]
  end
end

pp! ({10,20}).f(({20,30}))