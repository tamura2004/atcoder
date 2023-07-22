import java.util.Scanner

object Main extends App {
  val sc = new Scanner(System.in)
  val n = sc.nextInt

  if (n % 5 <= 2) {
    println(n - n % 5)
  } else {
    println((n + 4) / 5 * 5)
  }
}