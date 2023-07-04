def mex(a, b, c)
  ((0..3).to_a - [a, b, c]).min
end

pp mex(0, 1, 2)
