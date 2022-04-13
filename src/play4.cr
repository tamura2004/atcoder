require "crystal/avl_tree"

st = [1,2,3,4].to_ordered_set
pp st
st << 5
pp st