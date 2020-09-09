f = -> n {
  # return 1 if n < 3
  # return f.call(n-1) + f.call(n-2)
  return n * 2
}

pp f.call(10)