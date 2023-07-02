import java.util.Scanner
import scala.collection.immutable.Vector

object Main extends App {
  val sc = new Scanner(System.in)
  val s = Vector.fill(8) { sc.nextInt }

  var ans = true
  for (i <- 1 to 7) if (s(i - 1) > s(i)) ans = false
  for (v <- s) {
    if (v % 25 != 0) ans = false
    if (v < 100 || 675 < v) ans = false
  }
  println(if (ans) "Yes" else "No") 
}
