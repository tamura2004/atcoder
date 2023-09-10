class Bsearch[T: Ordering](val a: IndexedSeq[T]):
  def solve(query: T => Boolean): Option[T] =
    if a.isEmpty then return None
    if query(a(0)) then return Some(a(0))
    if !query(a.last) then return None
    var lo = 0
    var hi = a.length
    while (hi - lo) > 1 do
      val mid = (lo + hi) / 2
      if query(a(mid)) then hi = mid else lo = mid
    return Some(a(hi))

// エレベータクラス
case class Elevator(lo: Long, hi: Long) extends Ordered[Elevator]:
  override def compare(that: Elevator): Int =
    if this.lo == that.lo then
      (this.hi - that.hi).toInt
    else
      (this.lo - that.lo).toInt

object Main extends App:

  // ソートされた配列
  val sortedArray = Array(
    Elevator(20L,10L),
    Elevator(77L,15L),
    Elevator(10L,20L)
  )

  val ans = Bsearch[Elevator](sortedArray).solve(x => x.hi > 11)
  println(ans)
