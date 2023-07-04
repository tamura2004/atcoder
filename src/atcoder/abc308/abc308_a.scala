import java.util.Scanner
import scala.collection.immutable.Vector

object Main extends App {
  val sc = new Scanner(System.in)
  val s = Vector.fill(8) { sc.nextInt }

  def solve: Boolean = {
    s.forall(v => 100 <= v && v <= 675 && v % 25 == 0) &&
    (1 to 7).forall(i => s(i - 1) <= s(i))
  }

  println(if (solve) "Yes" else "No") 
}
