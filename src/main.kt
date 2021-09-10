fun main() {
  val (a, b, x) = readLine()!!.split(" ").map(String::toLong)
  if (a == 0L) println(b / x)
  else println(b / x - (a - 1) / x)
}
