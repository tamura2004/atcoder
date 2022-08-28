module IGraph
  abstract def n : Int32
  abstract def both : Bool
  abstract def origin : Int32
  abstract def each(&b : Int32 -> _)
  abstract def each(v : Int32, &b : Int32 -> _)
end
