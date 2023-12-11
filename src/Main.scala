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
  "3@4" match {
    case Hoge(hoge) => println(hoge)
    case _ => println("NO")
  }
}