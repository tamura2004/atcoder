import scala.io.StdIn
import scala.collection.mutable.TreeSet

object Main extends App:
  val n = StdIn.readInt()
  var bag = TreeSet[Int]()
  for i <- 1 to n * 2 + 1 do bag += i
  for _ <- 1 to n + 1 do
    val my_ball = bag.head
    println(my_ball)
    bag -= my_ball
    val your_ball = StdIn.readInt()
    if your_ball == 0 then sys.exit(0)
    bag -= your_ball
