a = [10,10,10]

cnt = a.zip(0..).slice_when do |(v, i)|
  i == 1
end.map(&.map(&.first)).to_a

pp cnt

