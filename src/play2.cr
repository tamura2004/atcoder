struct Edge
  property cost : Int32
  def initialize(@cost)
  end
end

h = { 1 => Edge.new(10) }

pp h[1]
h[1].cost = 20
pp h[1]