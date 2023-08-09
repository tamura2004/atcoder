import scala.io.StdIn
import scala.collection.immutable.TreeSet

def iotaSet(n: Int): TreeSet[Int] =
  if n < 0 then TreeSet[Int]() else (iotaSet(n - 1) + n)

def solve(bag: TreeSet[Int]): Unit =
  if bag.size > 0 then
    val ball = bag.last
    println(ball)
    solve(bag - ball - StdIn.readInt())

object Main extends App:
  val n = StdIn.readInt()
  val bag = iotaSet(n * 2 + 1)
  solve(bag)
