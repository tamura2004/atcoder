class UnionFind(var n: Int) {
  var par = new Array[Int](n)
  (0 until n).foreach { i =>
    par(i) = i
  }

  def root(v: Int): Int = {
    if (par(v) == v) {
      v
    } else {
      par(v) = root(par(v))
      par(v)
    }
  }

  def same(v: Int, nv: Int): Boolean = {
    root(v) == root(nv)
  }

  def unite(v: Int, nv: Int): Unit = {
    par(root(v)) = root(nv)
  }
}