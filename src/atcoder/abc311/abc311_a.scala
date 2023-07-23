import java.util.Scanner

object Main extends App {
  val sc = new Scanner(System.in)
  val n = sc.nextInt 
  val s = sc.next
  var cnt = 0
  for (i <- 0 until n) {
    cnt |= (1 << "ABC".indexOf(s(i)))

    if (cnt == 7) {
      println(i+1)
      sys.exit
    } 
  }
}