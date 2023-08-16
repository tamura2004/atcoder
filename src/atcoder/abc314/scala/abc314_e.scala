import io.StdIn.readLine
import scala.collection.mutable.ArrayBuffer

val buf = java.util.StringTokenizer(io.Source.stdin.mkString)
def sc = buf.nextToken

case class Roulettes(c:Int, p:Int, s:ArrayBuffer[Int], z:Int)

object Main extends App:
  val n, m = sc.toInt
  var memo = ArrayBuffer.fill(m) { None: Option[Double] }
  val roulettes = ArrayBuffer.fill(n) {
    val c = sc.toInt
    val p = sc.toInt
    val s = ArrayBuffer.fill(p) { sc.toInt }.filter(_ != 0)
    val z = p - s.size
    Roulettes(c, p, s, z)
  }

  def dfs(x:Int): Double =
    if x >= m then
      return 0.0
    
    memo(x) match
      case Some(ans) => ans
      case None =>
        var ans = 1e100

        for roulette <- roulettes do
          var cnt = 0.0

          val c = roulette.c
          val p = roulette.p
          val s = roulette.s
          val z = roulette.z

          for y <- s do
            cnt += dfs(x + y)

          cnt = (cnt + p * c) / (p - z)
          if ans > cnt then
            ans = cnt
        
        memo(x) = Some(ans)
        ans

  val ans = dfs(0)
  print(ans)
