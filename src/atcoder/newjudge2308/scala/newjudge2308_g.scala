import scala.collection.mutable.ArrayBuffer
import scala.collection.mutable.Stack

class CoodinateCompress(val arr: Array[Long]):
  val src = arr.sorted.distinct
  def apply(v: Long): Int =
    var lo = 0
    var hi = src.length

    while (hi - lo) > 1 do
      var mid = (hi + lo) / 2
      if v < src(mid) then hi = mid else lo = mid
    return lo

case class Elevator(lo: Long, hi: Long) extends Ordered[Elevator]:
  override def compare(that: Elevator): Int =
    if this.lo == that.lo then
      this.hi - that.hi
    else
      this.lo - that.lo

enum Position:
  case Bottom, Top, Mid

case class Event(lo: Long, pos: Position, hi: Long)

object Main extends App:
  val line = io.StdIn.readLine().split(" ").map(_.toInt)
  val n = line(0)
  val m = line(1)
  val q = line(2)

  var buildings = for
    i <- 0 until n
  yield
    ArrayBuffer.empty[Elevator]

  // ビルごとにエレベータを読み込んでまとめる
  for _ <- 0 until m do
    val line = io.StdIn.readLine().split(" ").map(_.toLong)
    val i = (line(0) - 1).toInt
    val lo = line(1)
    val hi = line(2)
    buildings(i) += Elevator(lo, hi)
  
  // ビルごとのエレベーターの銃f句を排除しつつ昇順にソート
  val compressed_buildings = for
    elevators <- buildings
  yield
    var nex = Stack.empty[Elevator]
    for elevator <- elevators.sorted do
      if nex.isEmpty || nex.last.hi < elevator.lo then
        nex.push(elevator)
      else
        val last = nex.pop
        nex.push(Elevator(last.lo, Math.max(last.hi, elevator.hi)))
    ArrayBuffer.empty[Elevator] ++= nex

  // 全エレベータの下階、上階をまとめてイベント列とキーを作る
  var keys = Stack.empty[Long]
  var events = Stack.empty[Event]

  for
    elevator <- 
  compressed_buildings

  println(compressed_buildings)
