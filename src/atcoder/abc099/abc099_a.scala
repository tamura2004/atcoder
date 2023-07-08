import java.util.Scanner

object Main extends App {
  val sc = new Scanner(System.in)
  val n = sc.nextInt
  println(if (n < 1000) "ABC" else "ABD")
}