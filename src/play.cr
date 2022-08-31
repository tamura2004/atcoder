module IGraph
  abstract def each(&b : Int32 -> _)
  abstract def each_with_cost(&b : (Int32,Int64) -> _)
end

class Graph
  include IGraph

  def each
    yield 1
    yield 2
    yield 3
  end

  def each_with_cost
    yield 1, 1_i64
    yield 2, 1_i64
    yield 3, 1_i64
  end
end

Graph.new.each do |i|
  pp i
  break if i == 2
end

Graph.new.each_with_cost do |i, cost|
  pp [i,cost]
  break if i == 2
end


