import java.util.Scanner

object Main extends App {
  val sc = new Scanner(System.in)
  val d = "A..BC...DE....F........G"
  val a = sc.next
  val b = sc.next
  val ans = d.indexOf(a) - d.indexOf(b)

  println(ans.abs)
}