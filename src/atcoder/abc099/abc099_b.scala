import java.util.Scanner

object Main extends App {
  val sc = new Scanner(System.in)
  val a = sc.nextInt
  val b = sc.nextInt
  var ans = -b
  for (i <- 1 to b - a) ans += i
  println(ans)
}