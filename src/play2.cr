# class Edge
#   getter from : Int32
#   getter to : Int32
#   getter cap : Int64
#   getter cost : Int64

#   def initialize(@from, @to, @cap : Int64, @cost : Int64)
#   end
# end

record Edge, s : Int32, t : Int32, cap : Int64, cost : Int64

x = Edge.new(0, 0, 0, 0)
pp! x