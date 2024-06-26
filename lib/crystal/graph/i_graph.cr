module IGraph
  abstract def n : Int32
  abstract def m : Int32
  abstract def both : Bool
  abstract def origin : Int32
  abstract def each : Iterator(Int32)
  abstract def each(i : Int32, &b : Int32 -> _)
  abstract def each_with_cost(i : Int32, &b : (Int32, Int64) -> _)
end
