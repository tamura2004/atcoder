x = [{1,2},{3,4}]

x.each_with_index do |(a,b),i|
  pp [a,b,i]
end