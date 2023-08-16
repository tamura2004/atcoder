import io.StdIn.readLine
import scala.collection.mutable.ArrayBuffer

val buf = java.util.StringTokenizer(io.Source.stdin.mkString)
def sc = buf.nextToken

object Main extends App:
  val n = sc.toInt
  val m = sc.toInt
  val s = sc
  val c = ArrayBuffer.fill(n) { sc.toInt - 1 }
  var cnt = ArrayBuffer.fill(m) { ArrayBuffer[Int]() }

  for i <- 0 until n do
    cnt(c(i)) += i

  var ix = ArrayBuffer.fill(n)(-1)
  for
    i <- 0 until m
    row = cnt(i)
    k = row.size
    j <- 0 until k
  do
    val jj = (j + 1) % k
    ix(row(jj)) = row(j)

  println(ix.map(s(_)).mkString)