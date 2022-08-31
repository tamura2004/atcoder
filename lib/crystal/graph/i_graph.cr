module IGraph
  abstract def n : Int32
  abstract def m : Int32
  abstract def both : Bool
  abstract def origin : Int32
  abstract def each(&b : Int32 -> _)
  abstract def each(v : Int32, &b : Int32 -> _)
  abstract def each_with_cost(v : Int32, &b : (Int32, Int64) -> _)
end
