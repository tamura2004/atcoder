record Node, i : Int32, cost : Int32 do
  property cost
end

n = Node.new(10,20)
pp n
n.cost = 40
pp n