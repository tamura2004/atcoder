import scala.collection.mutable.ArrayBuffer

class UnionFind(var n: Int) {
  var parent = 0 until n toArray

  def root(v: Int): Int = {
    if (parent(v) == v) {
      v
    } else {
      parent(v) = root(parent(v))
      parent(v)
    }
  }

  def same(v: Int, nv: Int): Boolean = root(v) == root(nv)
  def unite(v: Int, nv: Int): Unit = parent(root(v)) = root(nv)
}