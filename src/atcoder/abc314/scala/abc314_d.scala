import io.StdIn.readLine
import scala.collection.mutable.ArrayBuffer

val buf = java.util.StringTokenizer(io.Source.stdin.mkString)
def sc = buf.nextToken

case class Query(t:Int, x:Int, c:Char)

object Main extends App:
  val n = sc.toInt
  var s = StringBuilder(sc)
  val q = sc.toInt
  val queries = ArrayBuffer[Query]()
  for _ <- 0 until q do
    val t = sc.toInt
    val x = sc.toInt - 1
    val c = sc(0)
    queries += Query(t, x, c)

  var used = false
  val filtered = queries.reverse.filter(q => {
    if q.t == 1 then
      true
    else if used then
      false
    else
      used = true
      true
  }).reverse

  for query <- filtered do
    query.t match {
      case 1 => s(query.x) = query.c
      case 2 => s = StringBuilder(s.toString.toLowerCase)
      case 3 => s = StringBuilder(s.toString.toUpperCase)
    }

  println(s.toString)
