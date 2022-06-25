require "crystal/segment_tree"
require "crystal/modint9"

values = [1,2,3,4,5,6,7,8,9,10].map(&.to_m)
unit = ModInt.zero + 1

st = SegmentTree(ModInt).new(
  values: values,
  unit: unit,
  fx: -> (x : ModInt, y : ModInt) { x * y }
)

pp st[..9]