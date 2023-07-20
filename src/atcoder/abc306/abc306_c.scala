import java.util.Scanner
import scala.collection.mutable.ArrayBuffer

object Main extends App {
  val sc = new Scanner(System.in)
  val n = sc.nextInt
  val a = ArrayBuffer.fill(n*3)(sc.nextInt - 1)

  var cnt = ArrayBuffer.fill(n)(0)
  var ans = ArrayBuffer.fill(n)(-1)

  for (i <- 0 until n * 3) {
    cnt(a(i)) += 1
    if (cnt(a(i)) == 2) {
      ans(a(i)) = i + 1
    }
  }

  println(ans.zipWithIndex.sorted.map { case (_, c) => c + 1 }.mkString(" "))
}