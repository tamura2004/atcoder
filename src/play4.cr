x = [1,2,3,4]

pp x.each_with_object([0]) { |v, cs|
  cs << cs.last + v
}