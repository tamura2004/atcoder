import java.util.Scanner
import scala.collection.mutable.ArrayBuffer

object Main extends App {
  val sc = new Scanner(System.in)
  val n = sc.nextInt
  val a = sc.next.map(_.asDigit)
  val dp = ArrayBuffer.fill(n) { ArrayBuffer.fill(2) { 0L } }

  for (i <- 0 until n) {
    if (i == 0) {
      if (a(i) == 0) {
        dp(i)(0) += 1
      } else {
        dp(i)(1) += 1
      }
    } else {
      if (a(i) == 0) {
        dp(i)(1) += i
        dp(i)(0) += 1
      } else {
        dp(i)(1) += 1
        dp(i)(0) += dp(i-1)(1)
        dp(i)(1) += dp(i-1)(0)
      }
    }
  }
  
  val ans = dp.map(e => e(1)).sum
  println(ans)
}