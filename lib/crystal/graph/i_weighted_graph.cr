module IWeightedGraph
  abstract def each_with_cost(v : Int32, &b : (Int32, Int64) -> _)
end
