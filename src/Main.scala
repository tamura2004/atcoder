case class Hoge(a: Int, b: Int) {
  def encode: String = {
    Seq(a, b).map(_.toString).mkString("@")
  }
}

object Hoge {
  def unapply(hoge: String): Option[Hoge] = {
    val Reg = """^(.*)@(.*)$""".r
    hoge match {
      case Reg(a, b) => Some(Hoge(a.toInt, b.toInt))
      case _ => None
    }
  }
}

object Main extends App {
  val f = Future { Thread.sleep(10000); 21 + 21 }
  for {
    ff <- f
  } {
    println(ff)
  }
}