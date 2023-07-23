import java.util.Scanner
import scala.collection.mutable.ArrayBuffer

object Main extends App {
  val sc = new Scanner(System.in)
  val n = sc.nextInt
  var g = ArrayBuffer.fill(n) { new ArrayBuffer[Int]() }

  for (v <- 0 until n) {
    val nv = sc.nextInt - 1
    g(v).append(nv)
  }
  println(g)
}