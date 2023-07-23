import java.util.Scanner
import scala.collection.immutable.Vector
import scala.collection.mutable.ArrayBuffer
import scala.util.control.Breaks

object Main extends App {
  val sc = new Scanner(System.in)
  val n = sc.nextInt
  val nex = Vector.fill(n) { sc.nextInt - 1 }
  var ord = ArrayBuffer.fill(n) { -1 }
  var visit = ArrayBuffer[Int]()

  var v = 0
  var root = -1
  val b = new Breaks
  b.breakable {
    while (true) {
      ord(v) = visit.size
      visit.append(v)
      
      val nv = nex(v)
      if (ord(nv) != -1) {
        root = ord(nv)
        b.break
      } else {
        v = nv
      }
    }
  }
  val cycle = visit.slice(root, visit.size)
  println(cycle.size)
  println(cycle.map(_ + 1).mkString(" "))
}