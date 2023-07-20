import java.util.Scanner

object Main extends App {
  val sc = new Scanner(System.in)
  val a = Seq.fill(64)(BigInt(sc.nextInt))
  var ans : BigInt = 0
  for (i <- 0 until 64) {
    ans += a(i) * (BigInt(1) << i)
  }
  println(ans)
}