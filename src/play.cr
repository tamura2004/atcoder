record Edge, to : Int32, cost : Int32 do
  def [](i : Int)
    i.zero? ? to : cost
  end
end

x = Edge.new(10,20)
a,b = x
pp! a
pp! b