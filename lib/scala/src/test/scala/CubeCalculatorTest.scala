import org.scalatest._
import flatspec._
import matchers._

class CubeCalculatorTest extends AnyFlatSpec with should.Matchers {
  "CubeCalculator" should "cubed given value" in {
    CubeCalculator.cube(3) should be (27)
  }
}
