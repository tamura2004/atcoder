import scala.io.StdIn

def get2(): (Int, Int) =
  val line = StdIn.readLine().split(" ").map(_.toInt)
  return (line(0), line(1))

object Main extends App:
  val (l, r) = get2()
  val s = "atcoder"
  println(s.substring(l - 1, r))