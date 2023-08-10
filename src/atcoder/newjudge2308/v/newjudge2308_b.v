import lemoncmd.proconio { input }
import math { powi }

mut x := input[i64]()
k := input[i64]()

for i := 0; i < k; i++ {
  r := x % powi(10, i + 1)
  q := r / powi(10, i)
  if 5 <= q {
    x += powi(10, i + 1)
  }
  x -= r
}
println(x)
