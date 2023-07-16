import java.util.Scanner
import scala.collection.mutable.Set

object Main extends App {
  val sc = new Scanner(System.in)
  val n = sc.nextInt

  val uniq = Set[String]()
  val count = Set[String]()

  for (i <- 0 until n) {
    val s = sc.next
    val r = s.reverse

    if (s == r) {
      uniq += s
    } else {
      count += s
      count += r
    }
  }

  val ans = uniq.size + count.size / 2
  println(ans)
  
}