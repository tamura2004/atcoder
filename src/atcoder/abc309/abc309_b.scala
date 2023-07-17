import java.util.Scanner
import scala.collection.mutable.ArrayBuffer

object Main extends App {
  val sc = new Scanner(System.in)
  val n = sc.nextInt()
  val a = Array.fill(n) { sc.next() }
  var b = ArrayBuffer.tabulate(n, n) { (i, j) => a(i)(j) }

  var x, y, vx = 0
  var vy = 1

  for (_ <- 0 until 4) {
    for (_ <- 0 until n - 1) {
      b(y)(x) = a(y + vy)(x + vx)
      y += vy
      x += vx
    }
    val tmp = vx
    vx = vy
    vy = -tmp
  }
  for (i <- 0 until n) {
    println(b(i).mkString(""))
  }
}
