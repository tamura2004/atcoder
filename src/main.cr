require "crystal/lazy_segment_tree"

st = LazySegmentTree(Int64,Int64).range_add_range_max(10)
pp st[0i64..10]
