import java.util.Scanner
import scala.collection.mutable.ArrayBuffer
import scala.collection.mutable.Stack

object Main extends App {
  val sc = new Scanner(System.in)
  val n = sc.nextInt
  val t = sc.nextInt
  val m = sc.nextInt
  val dislike = ArrayBuffer.fill(n) { Set[Int]() }

  for (i <- 0 until m) {
    val a = sc.nextInt - 1
    val b = sc.nextInt - 1
    dislike(a) += b
    dislike(b) += a
  }

  val state = Stack[Set[Int]]()
  
  def solve(i: Int): Int = {
    if (t < state.size) return 0
    if (i == n) return (if (state.size == t) 1 else 0)

    var cnt = 0
    for (j <- 0 until state.size) {
      if (dislike(i).intersect(state(j)).isEmpty) {
        state(j) += i
        cnt += solve(i + 1)
        state(j) -= i
      }
    }
    state.push(Set(i))
    cnt += solve(i + 1)
    state.pop

    return cnt
  }

  println(solve(0))
}