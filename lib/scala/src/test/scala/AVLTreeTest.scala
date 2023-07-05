import org.scalatest._
import flatspec._
import matchers._

class AVLTreeTest extends AnyFlatSpec with should.Matchers {
  it should "usage" in {
    val a = new AVLTree()
    a.insert(3)
    a.insert(1)
    a.insert(4)
    a.insert(1)
    a.insert(5)

    a.includes(5) should be (true)
    a.upper(3) should be (Some(4))
    a.lower(3) should be (Some(1))
    a.upper(4) should be (Some(5))
    a.upper(5) should be (None)
    a.lower(1) should be (None)
    a.delete(5)
    a.upper(4) should be (None)

  }
}