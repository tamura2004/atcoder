import java.util.Scanner
import scala.collection.mutable.ArrayBuffer
import scala.collection.mutable.PriorityQueue

class Graph(val n: Int) {
  val g = ArrayBuffer.fill(n) { ArrayBuffer.empty[(Int, Long)] }

  def add(v: Int, nv: Int, cost: Long, origin: Int = 1, both: Boolean = true): Unit = {
    g(v - origin) += (((nv - origin), cost))
    if (both) g(nv - origin) += (((v - origin), cost))
  }

  def foreach(v: Int, f: ((Int, Long)) => Unit): Unit = {
    g(v).foreach(f)
  }
}

class SegmentTree(values: Seq[Long], f: (Long, Long) => Long) {
  var n = 1
  while (n < values.size) n *= 2
  val x = ArrayBuffer.fill(n*2){ Long.MaxValue }
  for (i <- 0 until values.size) x(i+n) = values(i)
  for (i <- n - 1 to 0 by -1) x(i) = f(x(i*2+1), x(i*2))

  def update(_i: Int, v: Long) = {
    var i = _i + n
    x(i) = v
    while (i > 1) {
      i /= 2
      x(i) = f(x(i * 2 + 1), x(i * 2))
    }
  }

  def apply(i: Int) = {
    x(i + n)
  }

  def query(_lo: Int, _hi: Int) = {
    var lo = _lo + n
    var hi = _hi + n
    var left = Long.MaxValue
    var right = Long.MaxValue

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
}

object Main extends App {
  val sc = new Scanner(System.in)
  val n = sc.nextInt
  val m = sc.nextInt
  val g = new Graph(n+1)

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

  val st = new SegmentTree(Seq(100L,200L,300L), (x: Long, y: Long) => {
    if (x > y) y else x
  })
  println(st.x)
  st(1) = 13
  println(st.x)
}