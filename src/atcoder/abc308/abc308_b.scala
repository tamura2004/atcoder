import java.util.Scanner
import scala.collection.mutable.TreeMap
import scala.collection.immutable.Vector

object Main extends App {
  val sc = new Scanner(System.in)
  val n = sc.nextInt
  val m = sc.nextInt
  val c = Vector.fill(n) { sc.next }
  val d = Vector.fill(m) { sc.next }
  val p = Vector.fill(m+1) { sc.nextInt }

  val dic = new TreeMap[String,Int]()
  for (i <- 0 until m) {
    dic(d(i)) = p(i+1)
  }

  var ans = 0
  for (i <- 0 until n) {
    dic get c(i) match {
      case Some(price) => ans += price
      case None => ans += p(0)
    }
  }
  println(ans)
}
