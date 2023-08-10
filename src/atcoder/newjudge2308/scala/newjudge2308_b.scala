import scala.io.StdIn

def get2(): (Long, Long) =
  val line = StdIn.readLine().split(" ").map(_.toLong)
  return (line(0), line(1))

object Main extends App:
  var (x, k) = get2()
  var base = 1L
  for i <- 0L until k do
    val y = base * 10L
    val r = x % y
    val q = r / base
    if 5 <= q then x += y
    x -= r
    base *= 10
  println(x)