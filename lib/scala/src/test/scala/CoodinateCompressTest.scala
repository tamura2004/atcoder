import org.scalatest._
import flatspec._
import matchers._

class CoodinateCompressTest extends AnyFlatSpec with should.Matchers {
  "CoodinateCompress" should "initialize with long array" in {
    val cc = CoodinateCompress([1000L, 2000L, 3000L])
    cc(1000L) should be (0)
    cc(2000L) should be (1)
    cc(3000L) should be (2)
  }
}
