require "crystal/bit_set"

x = 0_i64
pp x.class
x = x.on 31
pp x.class
pp x
pp x.popcount