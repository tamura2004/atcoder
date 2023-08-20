// import scala.collection.mutable.ArrayBuffer
import io.StdIn.readLine

val a = readLine()


// class UnionFind(var n: Int) {
//   var par = new Array[Int](n)
//   (0 until n).foreach { i =>
//     par(i) = i
//   }

//   def root(v: Int): Int = {
//     if (par(v) == v) {
//       v
//     } else {
//       par(v) = root(par(v))
//       par(v)
//     }
//   }

//   def same(v: Int, nv: Int): Boolean = {
//     root(v) == root(nv)
//   }

//   def unite(v: Int, nv: Int): Unit = {
//     par(root(v)) = root(nv)
//   }
// }

// object Main extends App {
//   val lines = io.Source.stdin.getLines()
//   val Array(n, q) = lines.next.split(" ").map(_.toInt)
//   val uf = new UnionFind(n)

//   for (line <- lines) {
//     val Array(t, v, nv) = line.split(" ").map(_.toInt)
//     if (t == 0) {
//       uf.unite(v, nv)
//     } else {
//       println(if (uf.same(v, nv)) "Yes" else "No")
//     }
//   }
// }
