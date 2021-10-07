require "crystal/grid"

g = Grid.new(3,4,["....","....","...."])
pp g.zigzag

(10..0).each do |i|
  pp! i
end
