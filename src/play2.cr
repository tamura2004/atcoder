f = -> (pair : Tuple(Int32,Int32)) {
  x,y = pair
  x * 100 + y * 20
}

pp f.call({1,2})