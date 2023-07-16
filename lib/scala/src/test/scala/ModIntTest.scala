import org.scalatest._
import flatspec._
import matchers._

class ModIntTest extends AnyFlatSpec with should.Matchers {
  it should "usage" in {
    val a = ModInt(998244353L + 7)
    val b = ModInt(998244353L + 11)

    (a + b).toLong should be (18)
    (a + 13L).toLong should be (20)
    (a + 17).toLong should be (24)

    (a * b).toLong should be (77)
    (a * 13L).toLong should be (91)
    (a * 17).toLong should be (119)
  }
}

