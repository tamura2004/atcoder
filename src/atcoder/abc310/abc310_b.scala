import java.util.Scanner
import scala.collection.mutable.Seq
import scala.collection.mutable.ArrayBuffer
import scala.collection.mutable.Set

object Main extends App {
  val sc = new Scanner(System.in)
  val n = sc.nextInt
  val m = sc.nextInt

  val prices = ArrayBuffer[Int]()
  val functions = ArrayBuffer[Set[Int]]()

  for (i <- 0 until n) {
    prices += sc.nextInt
    val cnt = sc.nextInt
    val function = Set[Int]()
    for (j <- 0 until cnt) {
      function += sc.nextInt
    }
    functions += function
  }

  for {
    i <- 0 until n
    j <- 0 until n
  } {
    if (
      prices(i) > prices(j) &&
      functions(i).subsetOf(functions(j))
    ) {
      println("Yes")
      sys.exit(0)
    }

    if (
      prices(i) >= prices(j) &&
      functions(i).subsetOf(functions(j)) &&
       (functions(j) -- functions(i)).size > 0
    ) {
      println("Yes")
      sys.exit(0)
    }
  }
  println("No")
}