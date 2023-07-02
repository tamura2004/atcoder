import java.util.Scanner
import scala.collection.immutable.Vector

case class Coin(a: Long, b: Long, i: Int) extends Ordered[Coin] {
  override def compare(other: Coin): Int = {
    val thisValue = value(other)
    val thatValue = other.value(this)
    if (thisValue < thatValue) -1
    else if(thisValue > thatValue) 1
    else if(i < other.i) 1
    else if(i > other.i) -1
    else 0
  }

  def value(other: Coin) = {
    a * (other.a + other.b)
  }
}

object Main extends App {
  val sc = new Scanner(System.in)
  val n = sc.nextInt
  val a = Vector.tabulate(n) { i =>
    Coin(sc.nextLong, sc.nextLong, i + 1)
  }
  println(a.sorted.reverse.map(_.i).mkString(" "))
}
