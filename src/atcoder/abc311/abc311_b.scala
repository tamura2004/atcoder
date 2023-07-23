import java.util.Scanner
import scala.collection.immutable.Vector

object Main extends App {
  val sc = new Scanner(System.in)
  val h = sc.nextInt
  val w = sc.nextInt
  val s = Vector.fill(h) { sc.next }

  var ans = 0
  var cnt = 0

  for(i <- 0 until w) {
    if (s.forall(row => row(i) == 'o')) {
      cnt += 1
      if (ans < cnt) ans = cnt
    } else {
      cnt = 0
    }
  }
  println(ans)
}