import java.util.Scanner
import scala.collection.mutable.ArrayBuffer

object Main extends App {
  val sc = new Scanner(System.in)
  val n = sc.nextInt
  val k = sc.nextInt

  var ab = ArrayBuffer.fill(n) {
    val a = sc.nextLong
    val b = sc.nextLong
    ((a, b))
  }.sorted.reverse

  var cs = ArrayBuffer(0L)

  for ((a, b) <- ab) {
    cs.append(cs(cs.size - 1) + b)
  }

  for (i <- 0 to n) {
    if (k < cs(i)) {
      println(ab(i-1)._1 + 1)
      sys.exit
    }
  }
  println(1)

} 