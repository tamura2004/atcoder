import scala.collection.mutable.ArrayBuffer

/*
 * セグメント木
 */
class SegmentTree[A](_n: Int, _f: (A, A) => A) {
  var n = 1
  while (n < _n) n *= 2
  val x = ArrayBuffer.fill(n * 2) { None: Option[A] }
  val f = (a: Option[A], b: Option[A]) => (a, b) match {
    case (Some(x), Some(y)) => Some(_f(x, y))
    case (Some(x), None)    => Some(x)
    case (None, Some(y))    => Some(y)
    case (None, None)       => None
  }
  // for (i <- 0 until values.size) x(i + n) = Some(values(i))
  // for (i <- n - 1 to 0 by -1) x(i) = f(x(i * 2 + 1), x(i * 2))

  def update(_i: Int, v: A): Unit = {
    var i = _i + n
    x(i) = Some(v)
    while (i > 1) {
      i >>= 1
      x(i) = f(x(i * 2 + 1), x(i * 2))
    }
  }

  def apply(i: Int): A = {
    x(i + n).get
  }

  def apply(r: Range): A = {
    var lo = r.head + n
    var hi = r.last + n + 1
    var left: Option[A] = None
    var right: Option[A] = None

    while (lo < hi) {
      if ((lo & 1) == 1) {
        left = f(left, x(lo))
        lo += 1
      }

      if ((hi & 1) == 1) {
        hi -= 1
        right = f(x(hi), right)
      }

      lo >>= 1
      hi >>= 1
    }
    f(left, right).get
  }

  def bsearch(_lo: Int)(f: A => Boolean): Option[Int] = {
    var lo = _lo
    var hi = n - 1

    if (f(apply(lo to lo))) return Some(lo)
    if (!f(apply(lo to hi))) return None

    while (hi - lo > 1) {
      val mid = (lo + hi) >> 1
      if (f(apply(_lo to mid))) hi = mid else lo = mid
    }
    Some(hi)
  }
}
