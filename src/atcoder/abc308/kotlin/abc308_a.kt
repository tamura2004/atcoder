fun main() {
  val a = readLine()!!.split(" ").map { it.toInt() }
  println(solve(a))
 }

fun solve(a: List<Int>): String {
  val n = a.size
  // 数列 a は広義単調増加である
  for (i in 0..(n-2)) {
    if (i != n - 1 && a[i] > a[i+1]) {
      return "No"
    }

    if (a[i] < 100 || 675 < a[i]) {
      return "No"
    }

    if (a[i] % 25 != 0) {
      return "No"
    }
  }
  return "Yes"
}