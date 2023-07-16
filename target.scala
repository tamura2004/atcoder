import java.util.Scanner
import scala.collection.mutable.ArrayBuffer
import scala.math._
// import local.ModInt

case class ModInt(_v : Long) {
  val MOD = 998244353L
  val v = (_v + MOD) % MOD
  def +(b : ModInt) = new ModInt(v + b.v)
  def +(b : Long) = new ModInt(v + b)
  def *(b : ModInt) = new ModInt(v * b.v)
  def *(b : Long) = new ModInt(v * b)
  def toLong = v
  override def toString = v.toString
}


object Main extends App {
  val sc = new Scanner(System.in)

  val n = sc.nextInt
  val a = ArrayBuffer.fill(n) { sc.nextLong }
  val dp = ArrayBuffer.fill(n+1) {
    ArrayBuffer.fill(11) { ModInt(0) }
  }
  dp(0)(0) = ModInt(1)

  for (i <- 0 until n) {
    for (j <- 0 to 10) {
      for (jj <- 1 to min(a(i), 10 - j)) {
        val jjj = j + jj
        if (jjj <= 10) {
          dp(i+1)(jjj) += dp(i)(j)
        }
      }
      dp(i+1)(j) += dp(i)(j) * a(i)
    }
  }

  var ans 
}