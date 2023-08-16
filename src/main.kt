fun main() {
  println("hello world".substring(0 until 4))
}

// class UnionFind(n : Int) {
//   var par = Array(n){it}

//   fun root(v : Int) : Int {
//     val pv = if (par[v] == v) v else root(par[v])
//     par[v] = pv
//     return pv
//   }

//   fun unite(_v : Int, _nv : Int) {
//     val v = root(_v)
//     val nv = root(_nv)
//     if (v != nv) par[v] = nv
//   }

//   fun same(v : Int, nv : Int) : Boolean {
//     return root(v) == root(nv)
//   }
// }

// fun main() {
//   val (n, q) = readLine()!!.split(" ").map(String::toInt)
//   val uf = UnionFind(n)

//   for (i in 1..q) {
//     val (t, v, nv) = readLine()!!.split(" ").map(String::toInt)
//     if (t == 0) {
//       uf.unite(v, nv)
//     } else {
//       println(if (uf.same(v, nv)) "Yes" else "No")
//     }
//   }
// }
