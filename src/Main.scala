import scala.concurrent.Future
import scala.concurrent.ExecutionContext.Implicits.global


object Main extends App {
  def yesno(f: (Int,Int) => Boolean) = {
    if (f(10,20)) "Yes" else "No"
  }

  println(yesno(_ < _))
}