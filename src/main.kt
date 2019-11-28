import java.util.*
import java.io.*

fun solve(a: Long, b: Long) {
    when((a*b)%2) {
        0L -> "Even"
        else -> "Odd"
    }.let{println(it)}
    return
}

fun main(args: Array<String>) {
    val sc = Scanner(System.`in`)
    val a = sc.next().toLong()
    val b = sc.next().toLong()
    solve(a,b)
}