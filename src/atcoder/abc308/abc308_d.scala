import java.util.Scanner
import scala.collection.mutable.ArrayBuffer

class Graph(n: Int) {
  val g = ArrayBuffer.fill(n) { new ArrayBuffer[Int]() }

  def add(v: Int, nv: Int) = {
    g(v) += nv
    g(nv) += v
  }

  def apply(v: Int) = g(v)
}

object Main extends App {
  val sc = new Scanner(System.in)
  val g = new Graph(6)
  g.add(1, 2)
  g.add(2, 3)
  g(2).foreach { nv =>
    println((2, nv))
  }
}