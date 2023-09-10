class CoodinateCompress(val arr: Array[Long]) {
  val src = arr.sorted.distinct

  def apply(v: Long): Int = {
    var lo = 0
    var hi = src.length

    while ((hi - lo) > 1) {
      var mid = (hi + lo) / 2
      if (v < src(mid)) {
        hi = mid
      } else {
        lo = mid
      }
    }
    return lo
  }
}

import scala.collection.mutable.TreeSet

object Main extends App {
  val a = Array(1000L,3000L,2000L,-1000L)
  val cc = CoodinateCompress(a)
  println(cc)
  println(cc(-1000L))
  println(cc(1000L))
  println(cc(2000L))
  println(cc(3000L))
}
