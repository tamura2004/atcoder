require "crystal/indexable"

lo = hi = 100i64
hi += 100
pp (lo..hi).size.class.new(100)
