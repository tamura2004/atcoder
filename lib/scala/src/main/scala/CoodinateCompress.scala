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