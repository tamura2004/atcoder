import java.util.*

fun main() {
  val (l, q) = readLine()!!.split(" ").map(String::toInt)
  var tr = TreeSet<Int>(listOf(0,l))
  var ans = mutableListOf<Int>()

  for (i in 1..q) {
    val (c, x) = readLine()!!.split(" ").map(String::toInt)
    if (c == 1) {
      tr.add(x)
    } else {
      ans.add(tr.higher(x) - tr.lower(x))
    }
  }

  println(ans.joinToString(separator = "\n"))
}