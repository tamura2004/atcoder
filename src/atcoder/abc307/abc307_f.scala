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

  def foreach(v: Int)(f: ((Int, Long)) => Unit): Unit = {
    g(v).foreach(f)
  }
}

class SegmentTree[A](values: ArrayBuffer[A], _f: (A, A) => A) {
  var n = 1
  while (n < values.size) n *= 2
  val x = ArrayBuffer.fill(n * 2) { None: Option[A] }
  val f = (x: Option[A], y: Option[A]) => {
    (x, y) match {
      case (Some(x), Some(y)) => Some(_f(x, y))
      case (Some(x), None)    => Some(x)
      case (None, Some(y))    => Some(y)
      case (None, None)       => None
    }
  }
  for (i <- 0 until values.size) x(i + n) = Some(values(i))
  for (i <- n - 1 to 0 by -1) x(i) = f(x(i * 2 + 1), x(i * 2))

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

    if (f(this(lo to lo))) return Some(lo)
    if (!f(this(lo to hi))) return None

    while (hi - lo > 1) {
      val mid = (lo + hi) >> 1
      if (f(this(_lo to mid))) hi = mid else lo = mid
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
  val st = new SegmentTree(values, (x: Long, y: Long) => if (x < y) y else x)

  val ans = ArrayBuffer.fill(n + 1) { None: Option[Long] }
  val q = PriorityQueue[(Int, Long, Int)]().reverse
  q.enqueue((0, 0L, 0))

  println(s"values= $values")

  while (q.size > 0) {
    val (i, cost, v) = q.dequeue
    if (ans(v) == None) {
      ans(v) = Some(i)

      g.foreach(v) { (nv, ncost) =>
        {
          if (ans(nv) == None) {
            if (cost + ncost <= values(i)) {
              q.enqueue((i, cost + ncost, nv))
            } else {
              st.bsearch(i + 1) { _ >= ncost } match {
                case Some(j) => q.enqueue((j, ncost, nv))
                case None => {}
              }
k            }
          }
        }
      }
    }
  }

  for (v <- ans.tail) {
    v.map(v => println(v))
  }

}
