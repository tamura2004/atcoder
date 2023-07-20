import java.util.Scanner
import scala.collection.mutable.ArrayBuffer

object Main extends App {
  val sc = new Scanner(System.in)
  val n = sc.nextInt
  var dp = ArrayBuffer.tabulate(n + 1, 2) {
    (_, _) => java.lang.Long.MIN_VALUE / 4
  }
  dp(0)(0) = 0L

  for (i <- 0 until n) {
    val x = sc.nextInt
    val y = sc.nextInt

    if (dp(i+1)(0) < dp(i)(0)) dp(i+1)(0) = dp(i)(0)
    if (dp(i+1)(1) < dp(i)(1)) dp(i+1)(1) = dp(i)(1)

    if (x == 0) {
      if (dp(i+1)(0) < dp(i)(0) + y) dp(i+1)(0) = dp(i)(0) + y
      if (dp(i+1)(0) < dp(i)(1) + y) dp(i+1)(0) = dp(i)(1) + y
    } else {
      if (dp(i+1)(x) < dp(i)(0) + y) dp(i+1)(x) = dp(i)(0) + y
    }
  }

  println(dp.last.max)
}