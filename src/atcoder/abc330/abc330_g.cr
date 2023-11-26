# 答えを決め打つ二分探索
# 答えがXの時充足するか
# x軸y軸を独立に考えて良い

query = -> (x : Int64) {
  100 < x
}

lo = 0_i64
hi = 1e10.to_i64
pp (lo..hi).bsearch(&query)
