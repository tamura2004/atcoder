module IMatrixGraph
  abstract def get(i : Int32, j : Int32) : Int64
  abstract def update(i : Int32, j : Int32, cost : Int64)
end