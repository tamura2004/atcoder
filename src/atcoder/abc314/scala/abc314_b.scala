import io.StdIn.readLine
import scala.collection.mutable.ArrayBuffer

case class Player(id: Int, num: Int, bet: Array[Int])

object Main extends App:
  val n = readLine.toInt
  var players = ArrayBuffer[Player]()

  for i <- 0 until n do
    val c = readLine.toInt
    val a = readLine.split(" ").map(_.toInt)
    players += Player(i + 1, c, a)

  val x = readLine.toInt

  val winner = players.filter(_.bet.contains(x))

  if winner.isEmpty then
    println(0)
  else
    val mini = winner.map(_.num).min
    val ans = winner.filter(_.num == mini)
    println(ans.size)
    println(ans.map(_.id).mkString(" "))
