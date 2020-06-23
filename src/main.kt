import java.util.*

fun main(args: Array<String>) {
  val sc = Scanner(System.`in`)
  val a = sc.next().toInt()
  val b = sc.next().toInt()
  if ((a * b) % 2 == 0) {
    println("Even")
  } else {
    println("Odd")
  }
}