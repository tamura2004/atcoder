import java.util.Scanner

object Main extends App {
  val sc = new Scanner(System.in)
  val n = sc.nextInt
  var dp = Array.fill(100, 100, 100) { None: Option[Int] }

  for (i <- 0 until n) {
    val x1 = sc.nextInt
    val y1 = sc.nextInt
    val z1 = sc.nextInt
    val x2 = sc.nextInt
    val y2 = sc.nextInt
    val z2 = sc.nextInt

    for {
      x <- x1 until x2
      y <- y1 until y2
      z <- z1 until z2
    } {
      dp(x)(y)(z) = Some(i)
    }
  }

  var ans = Array.fill(n) { Set[Int]() }

  for {
    x <- 0 until 100
    y <- 0 until 100
    z <- 0 until 100
    i <- dp(x)(y)(z)
    dx <- 0 to 1
    dy <- 0 to 1
    dz <- 0 to 1
    if dx + dy + dz == 1
    if x + dx < 100
    if y + dy < 100
    if z + dz < 100
    j <- dp(x + dx)(y + dy)(z + dz)
    if i != j
  } {
    ans(i) += j
    ans(j) += i
  }

  for (i <- 0 until n) {
    println(ans(i).size)
  }
}