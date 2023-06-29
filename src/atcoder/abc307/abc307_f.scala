import java.util.Scanner
import scala.collection.mutable.ArrayBuffer
import scala.collection.mutable.PriorityQueue

class Graph(val n: Int) {
  val g = ArrayBuffer.fill(n) { ArrayBuffer.empty[(Int, Long)] }

  def add(
      v: Int,
      nv: Int,
      cost: Long,
      origin: Int = 1,
      both: Boolean = true
  ): Unit = {
    g(v - origin) += (((nv - origin), cost))
    if (both) g(nv - origin) += (((v - origin), cost))
  }

  def foreach(v: Int, f: ((Int, Long)) => Unit): Unit = {
    g(v).foreach(f)
  }
}

class SegmentTree(values: ArrayBuffer[Long], f: (Long, Long) => Long) {
  var n = 1
  while (n < values.size) n *= 2
  val x = ArrayBuffer.fill(n * 2) { Long.MinValue }
  for (i <- 0 until values.size) x(i + n) = values(i)
  for (i <- n - 1 to 0 by -1) x(i) = f(x(i * 2 + 1), x(i * 2))

  def update(_i: Int, v: Long) = {
    var i = _i + n
    x(i) = v
    while (i > 1) {
      i >>= 1
      x(i) = f(x(i * 2 + 1), x(i * 2))
    }
  }

  def apply(i: Int) = {
    x(i + n)
  }

  def query(_lo: Int, _hi: Int) = {
    var lo = _lo + n
    var hi = _hi + n
    var left = Long.MinValue
    var right = Long.MinValue

    while (lo < hi) {
      if (lo % 2 == 1) {
        left = f(left, x(lo))
        lo += 1
      }

      if (hi % 2 == 1) {
        hi -= 1
        right = f(x(hi), right)
      }

      lo /= 2
      hi /= 2
    }
    f(left, right)
  }

  def bsearch(_lo: Int, g: Long => Boolean): Option[Int] = {
    var lo = _lo
    var hi = n
    if (!g(this.query(_lo, hi))) return None
    while ((hi - lo) > 1) {
      val mid = (lo + hi) / 2
      if (g(this.query(_lo, mid))) {
        hi = mid
      } else {
        lo = mid
      }
    }
    Some(hi)
  }
}

object Main extends App {
  val sc = new Scanner(System.in)
  val n = sc.nextInt
  val m = sc.nextInt
  val g = new Graph(n + 1)

  for (_ <- 1 to n) {
    val v = sc.nextInt
    val nv = sc.nextInt
    val cost = sc.nextLong
    g.add(v, nv, cost, origin = 0)
  }

  val k = sc.nextInt
  for (_ <- 1 to k) {
    val v = sc.nextInt
    g.add(0, v, cost = 0L, origin = 0)
  }

  val d = sc.nextInt
  val values = ArrayBuffer.fill(d + 1) { 0L }
  for (i <- 1 to d) { values(i) = sc.nextLong }
  val st = new SegmentTree(
    values,
    (x: Long, y: Long) => {
      if (x < y) y else x
    }
  )

  val ans = ArrayBuffer.fill(n + 1) { Int.MaxValue }
  val q = PriorityQueue[(Int, Long, Int)]().reverse
  q.enqueue((0, 0L, 0))
  while (q.size > 0) {
    val (i, cost, v) = q.dequeue
    if (ans(v) == Int.MaxValue) {
      ans(v) = i

      g.foreach(
        v,
        (nv, ncost) => {
          println((v, nv, ncost, i, cost, values))
          if (ans(nv) == Int.MaxValue) {
            if (cost + ncost <= values(i)) {
              q.enqueue((i, cost + ncost, nv))
            } else {
              val j = st.bsearch(
                i,
                cost => {
                  ncost <= cost
                }
              )
              j match {
                case Some(jj) => {
                  q.enqueue((jj-1, ncost, nv))
                }
                case None => {}
              }
            }
          }
        }
      )
    }
  }
  println(ans)
}
