import java.util.Scanner

object Main extends App {
  def isKaibun(s: String): Boolean = {
    val n = s.size
    (0 to n / 2).forall { i =>
      s(i) == s(n - 1 - i)
    }
  }

  val sc = new Scanner(System.in)
  val n = sc.nextInt
  val s = Vector.fill(n) { sc.next }

  val ans = for {
    i <- 0 until n
    j <- 0 until n
    if i != j
  } yield isKaibun(s(i) + s(j))

  if (ans.contains(true)) println("Yes")
  else println("No")
}