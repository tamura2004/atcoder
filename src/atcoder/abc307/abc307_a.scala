import java.util.Scanner

object Main extends App {
  val sc = new Scanner(System.in)
  val n = sc.nextInt
  val a = List.fill(n * 7) { sc.nextInt }
  val ans = a.grouped(7).map(_.sum).toList
  println(ans.mkString(" "))
}