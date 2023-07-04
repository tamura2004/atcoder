import org.scalatest._
import flatspec._
import matchers._
import scala.collection.mutable.ArrayBuffer

class SegmentTreeTest extends AnyFlatSpec with should.Matchers {
  it should "range min query" in {
    val st = new SegmentTree[Int](
      11,
      (x: Int, y: Int) => if (x < y) x else y
    )

    st(0) = 3
    st(1) = 1
    st(2) = 4
    st(3) = 1
    st(4) = 5
    st(5) = 9
    st(6) = 2
    st(7) = 6
    st(8) = 5
    st(9) = 3
    st(10) = 5

    // 3 1 4 1 5 9 2 6 5 3 5

    st(0 to 3) should be (1)
    st(1 to 4) should be (1)
    st(2 to 5) should be (1)
    st(3 to 6) should be (1)
    st(4 to 7) should be (2)
    st(5 to 8) should be (2)
    st(6 to 9) should be (2)
    st(7 to 10) should be (3)

    st(1) = 9
    st(3) = 9
    st(6) = 9

    // 3 9 4 9 5 9 9 6 5 3 5

    st(0 to 3) should be (3)
    st(1 to 4) should be (4)
    st(2 to 5) should be (4)
    st(3 to 6) should be (5)
    st(4 to 7) should be (5)
    st(5 to 8) should be (5)
    st(6 to 9) should be (3)
    st(7 to 10) should be (3)

    st.bsearch(3)(3 >= _) should be (Some(9))
    st.bsearch(0)(3 >= _) should be (Some(0))
    st.bsearch(3)(2 >= _) should be (None)
  }
}
