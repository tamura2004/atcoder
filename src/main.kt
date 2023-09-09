fun main() {
  // val a = readLine()!!.toInt()
  // val (b, c) = readLine()!!.split(" ").map { it.toInt() }
  var x = 10
  x += 10

  println(x)

  // 長さ10の配列
  val a = Array(10) { 0 }
  println(a.toList())

  // String -> Intのマップ
  val dic = HashMap<String, Int>()
  dic["hoge"] = 10
  println(dic["hoge"])
  println(dic.containsKey("hoge"))

  // 空の配列と要素の追加
  var arr = emptyArray<Int>()
  arr += 10
  arr += 20
  arr += 30
  println(arr.toList())


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
