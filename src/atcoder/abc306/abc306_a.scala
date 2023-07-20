import java.util.Scanner

object Main extends App {
  val sc = new Scanner(System.in)
  val n = sc.nextInt
  val s = sc.next
  val ans = s.flatMap(c => Seq.fill(2)(c)).mkString
  println(ans)
}