import scala.concurrent.Future
import scala.concurrent.ExecutionContext.Implicits.global

object Main extends App {
  val s = "Hello"
  val n = 10

  val futureList = Seq.tabulate(n) { i =>
    Future {
      Thread.sleep((n + 1 - i) * 1)
      s + " future" + i + "!"
    }
  }

  for {
    future <- futureList
    s <- future
  } {
    println(s)
  }

  Thread.sleep(3000)
}