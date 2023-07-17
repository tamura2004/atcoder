import java.util.Scanner

// 1 2 3
// 4 5 6
// 7 8 9

object Main extends App {
  val sc = new Scanner(System.in)
  val a = sc.nextInt()
  val b = sc.nextInt()

  // 3で整除した結果が同じ
  // a + 1 == b
  if (a + 1 == b && a % 3 != 0) {
    println("Yes")
  } else {
    println("No")
  }
}