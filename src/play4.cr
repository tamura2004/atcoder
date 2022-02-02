# require "crystal/segment_tree"

# a = [0,5,4,1,3,2]
# st = SegmentTree(Int32).new(a)
# pp st[1_i64..2]

alias I = Int32 | Int64

def hoge(r : Range(I?,I?))
  r
end

pp hoge(10..20_i64)