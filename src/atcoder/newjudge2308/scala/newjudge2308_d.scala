import scala.io.StdIn
import scala.collection.mutable.ArrayBuffer
import scala.collection.mutable.Queue

def get2(): (Int, Int) =
  val line = StdIn.readLine().split(" ").map(_.toInt)
  return (line(0), line(1))

def get3(): (Int, Int, Int) =
  val line = StdIn.readLine().split(" ").map(_.toInt)
  return (line(0), line(1), line(2))

def depth(g: Array[ArrayBuffer[Int]], root: Int): Array[Int] =
  var depth = Array.fill(g.length) { -1 }
  depth(root) = 0
  var q = Queue[Int]()
  q += root
  while q.length > 0 do
    val v = q.dequeue
    for nv <- g(v) do
      if depth(nv) == -1 then
        depth(nv) = depth(v) + 1
        q += nv
  return depth

object Main extends App:
  var (n1, n2, m) = get3()
  var g = Array.fill(n1+n2) { ArrayBuffer[Int]() }
  for _ <- 0 until m do
    val (v, nv) = get2()
    g(v-1) += nv-1
    g(nv-1) += v-1
  
  val d1 = depth(g, 0)
  val d2 = depth(g, n1 + n2 - 1)
  val ans = d1.max + d2.max + 1
  println(ans)
