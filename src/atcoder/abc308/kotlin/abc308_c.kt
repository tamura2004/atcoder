// ai/(ai + bi) < aj/(aj + bj) === ai*(aj + bj) < aj*(ai + bi)
// ブロック付きソート

data class User(val id: Int, val p: Double)parable<User> {
  override fun compareTo(other: User): Int {
    if (a * (other.a + other.b) == other.a * (a + b)) {
      if (other.id == id) {
        return 0
      } else if (other.id > id) {
        return 1
      } else {
        return -1
      }
    } else {
      if (a * (other.a + other.b) > other.a * (a + b)) {
        return 1
      } else {
        return -1
      }
    }
  }
}

fun main() {
  val n = readLine()!!.toLong()
  var users = emptyArray<User>()
  for (i in 1..n) {
    val (a, b) = readLine()!!.split(" ").map { it.toLong() }
    users += User(i, a, b)
  }

  var ans = users.sorted().reversed().map { it.id }
  println(ans.joinToString(separator = " "))
}