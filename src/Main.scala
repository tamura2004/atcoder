import scala.collection.mutable.ArrayBuffer
import scala.collection.mutable.HashMap

object Main extends App {
  val a = ArrayBuffer(1,2,3)
  val b = ArrayBuffer(1,2,3)
  val h = HashMap(a -> 123)
  println(a.zip(b).map((a : Int, b : Int) => a + b))
}