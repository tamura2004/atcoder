import java.util.Scanner
import scala.collection.mutable._

object Main extends App {
  val sc = new Scanner(System.in)
  val h = sc.nextInt
  val w = sc.nextInt
  val s = ArrayBuffer.fill(h) { sc.next }

  def solve: Boolean = {

    val g = for (t <- s) yield {
      for (c <- t) yield {
        c match {
          case 's' => 0
          case 'n' => 1
          case 'u' => 2
          case 'k' => 3
          case 'e' => 4
          case _   => 99
        }
      }
    }

    if (g(0)(0) == 99) return false

    val seen = HashSet((0, 0))
    val q = Queue((0, 0))

    while (q.nonEmpty) {
      val (y, x) = q.dequeue
      if (y + 1 == h && x + 1 == w) return true

      for {
        ny <- y - 1 to y + 1
        nx <- x - 1 to x + 1
        if (ny - y).abs != (nx - x).abs
        if 0 until h contains ny
        if 0 until w contains nx
        if !(seen contains ((ny, nx)))
        if (g(y)(x) + 1) % 5 == g(ny)(nx)
      } {
        seen += ((ny, nx))
        q += ((ny, nx))
      }
    }
    return false
  }

  println(if (solve) "Yes" else "No")
}