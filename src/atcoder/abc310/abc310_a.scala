import java.util.Scanner
import scala.collection.mutable.Seq
import scala.math.min

object Main extends App {
  val sc = new Scanner(System.in)

  val n = sc.nextInt
  val p = sc.nextInt
  val q = sc.nextInt
  val d = Seq.fill(n) { sc.nextInt }
  
  val ans = min(p, q + d.min)
  println(ans)
  
}