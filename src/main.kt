import kotlinx.coroutines.*
import kotlinx.coroutines.flow.*

fun soumen(): Flow<String> = sequence {
  val soumens = listOf("a", "b", "c")
  for (i in 0..2) {
    delay(500)
    emit(soumens[i])
  }
}

fun main() = runBlocking<Unit> {
  launch {
    for (k in 1..3) {
      println("I'm not blocked $k")
      delay(500)
    }
  }
  soumen().collect { value -> println(value) }
}
