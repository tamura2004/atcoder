fun main() {
  val (n, m) = readLine()!!.split(" ").map { it.toInt() }
  val eat = readLine()!!.split(" ")
  val color = readLine()!!.split(" ")
  val price = readLine()!!.split(" ").map { it.toInt() }
  var book = HashMap<String, Int>()
  for (i in 0..m-1) {
    book[color[i]] = price[i+1]
  }

  var ans = 0
  for (i in 0..n-1) {
    if (book.containsKey(eat[i])) {
      ans += book[eat[i]]!!
    } else {
      ans += price[0]
    }
  }
  println(ans)
}