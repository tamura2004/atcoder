import java.util.Scanner
import scala.collection.mutable.ArrayBuffer
import local.ModInt

object Main extends App {
  val sc = new Scanner(System.in)
  val n = sc.nextInt
  val m = sc.nextInt

  var dp = ArrayBuffer.fill(n+1){ArrayBuffer.fill(2){new ModInt(0)}}
  dp(0)(1) = new ModInt(1)

  (0 until n).foreach { i =>
    dp(i+1)(0) += dp(i)(0) * (m - 2)
    dp(i+1)(0) += dp(i)(1) * (m - 1)
    dp(i+1)(1) += dp(i)(0)
  }
  println(dp(n)(1) * m)
}