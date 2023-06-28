import java.util.Scanner
import scala.collection.mutable.Stack

object Main extends App {
  val sc = new Scanner(System.in)

  val n = sc.nextInt
  val s = sc.next

  val ans = new Stack[Char]()
  val bgn = new Stack[Int]()

  s.foreach {
    case '(' => {
      bgn.push(ans.size)
      ans.push('(')
    }
    case ')' => {
      if (bgn.size == 0) {
        ans.push(')')
      } else {
        val i = bgn.pop
        while (i < ans.size) {
          ans.pop
        }
      }
    }
    case c => {
      ans.push(c)
    }
  }

  println(ans.mkString.reverse)
}
