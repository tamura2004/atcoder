import java.util.Scanner
import scala.collection.mutable.Queue
import scala.collection.mutable.HashSet

object Main extends App {
  sealed trait Motion
  case object Up extends Motion
  case object Down extends Motion
  case object Left extends Motion
  case object Right extends Motion
  case object Stop extends Motion

  val sc = new Scanner(System.in)
  val h = sc.nextInt
  val w = sc.nextInt
  val g = Array.fill(h) { sc.next }
  var q = new Queue[(Int,Int,Motion)]()
  q += ((1, 1, Stop))

  var seen = Array.tabulate(h, w) { (y: Int, x: Int) => new HashSet[Motion]() }
  seen(1)(1) += Stop

  while (q.size > 0) {
    val (y, x, dir) = q.dequeue

    for {
      (dy, dx, ndir) <- Seq((-1, 0, Up), (1, 0, Down), (0, -1, Left), (0, 1, Right))
      if dir == Stop || dir == ndir
    } {
      val ny = y + dy
      val nx = x + dx

      if (g(ny)(nx) == '#') {
        if (dir != Stop) { q += ((y, x, Stop)) }
      } else if (!seen(ny)(nx).contains(ndir)) {
        seen(ny)(nx) += ndir
        q += ((ny, nx, ndir))
      }
    }
  }

  var ans = 0
  for (y <- 0 until h) {
    for (x <- 0 until w) {
      if (!seen(y)(x).isEmpty) {
        ans += 1
      }
    }
  }
  println(ans)
}