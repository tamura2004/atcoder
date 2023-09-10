def getv(): Array[Int] = io.StdIn.readLine().split(" ").map(_.toInt)
def get3(): (Int, Int, Int) =
  val v = getv()
  return (v(0), v(1), v(2))

case class Potion(id: Int, hp: Int)

object Main extends App:
  val (n, h, x) = get3()
  val potions = getv().zipWithIndex.map((hp, i) => Potion(i+1, hp))
  val ans = potions.filter(x <= h + _.hp).head
  println(ans.id)
