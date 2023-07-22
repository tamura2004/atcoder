import java.util.Scanner
import scala.collection.immutable.Vector

object Main extends App {
  val sc = new Scanner(System.in)
  val h = sc.nextInt
  val w = sc.nextInt
  var g = Vector.fill(h) { sc.next.toVector }
  val seen = for(_ <- 1 to 2) yield {
    g = g.transpose
    g.map(_.contains('#'))
  }

  for {
    y <- 0 until h
    x <- 0 until w
    if g(y)(x) == '.'
    if seen(0)(x)
    if seen(1)(y)
  } {
    println(s"${y + 1} ${x + 1}")
  }
}