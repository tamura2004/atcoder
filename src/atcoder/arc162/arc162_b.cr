require "crystal/inversion_number"

a = [Int64::MAX, 1_i64, 0_i64, Int64::MIN]
pp a.inversion_number
