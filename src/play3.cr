a = 10
f = -> (a : Int32) {
  a * 2
}
pp f.call(3)
pp a