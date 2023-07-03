import org.scalatest._
import flatspec._
import matchers._

class UnionFindTest extends AnyFlatSpec with should.Matchers {
  it should "usage" in {
    val uf = new UnionFind(4)
    uf.same(0, 0) should be (true)
    uf.same(3, 3) should be (true)
    uf.same(0, 3) should be (false)

    uf.unite(0, 1)
    uf.unite(3, 1)
    uf.same(0, 3) should be (true)
    uf.same(1, 0) should be (true)
  }
}
