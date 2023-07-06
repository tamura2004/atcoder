import java.util.Scanner
import scala.collection.mutable.TreeMap

class Multiset {
  val tm = new TreeMap[Int, Int]()

  def <<(v: Int): Unit = {
    if (tm isDefinedAt v) {
      tm(v) += 1
    } else {
      tm(v) = 1
    }
  }

  def delete(v: Int): Unit = {
    if (tm isDefinedAt v) {
      tm(v) -= 1
      if (tm(v) == 0) tm.remove(v)
    }
  }

  def isDefinedAt(v: Int): Boolean = {
    tm isDefinedAt v
  }

  def min: Int = tm.firstKey
}

object Main extends App {
  val sc = new Scanner(System.in)
  val st = new Multiset()
  val mini = new Multiset()

  val q = sc.nextInt
  for (_ <- 1 to q) {
    val cmd = sc.nextInt
    cmd match {
      case 1 => {
        val x = sc.nextInt
        if (st isDefinedAt x) {
          mini << 0
        } else {
          val left = st.tm.maxBefore(x)
          val right = st.tm.minAfter(x + 1)
          (left, right) match {
            case (None, None) => ()
            case (Some((u, _)), None) => mini << (x ^ u)
            case (None, Some((v, _))) => mini << (x ^ v)
            case (Some((u, _)) Some((v, _))) => {
              mini.delete(u ^ v)
              mini << (x ^ u)
              mini << (x ^ v)
            }
          }
        }
        st << x
      }
      case 2 => {
        val x = sc.nextInt
        st.delete(x)
        if (st isDefinedAt x) {
          mini.delete(0)
        } else {
          left = st.tm.maxBefore(x)
          right = st.tm.minAfter(x + 1)
          (left, right) match {
            case (None, None) => ()
            case (Some((u, _)), None) => mini.delete(x ^ u)
            case (None, Some((v, _))) => mini.delete(x ^ v)
            case (Some((u, _)), Some((v, _))) => {
              mini << (u ^ v)
              mini.delete(x ^ u)
              mini.delete(x ^ v)
            }
          }
        }
      }
      case 3 => {
        println(mini.min)
      }
    }
  }
}
