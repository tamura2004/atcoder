import scala.concurrent.Future
import scala.concurrent.ExecutionContext.Implicits.global


object Main extends App {
  val f = Future { Thread.sleep(10000); 21 + 21 }
  for {
    ff <- f
  } {
    println(ff)
  }
}