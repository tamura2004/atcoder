import scala.collection.mutable.ArrayBuffer
import scala.collection.mutable.Stack

// 座標圧縮ライブラリ
class CoodinateCompress(val arr: Array[Long]):
  val src = arr.sorted.distinct
  def apply(v: Long): Int =
    var lo = 0
    var hi = src.length

    while (hi - lo) > 1 do
      var mid = (hi + lo) / 2
      if v < src(mid) then hi = mid else lo = mid
    return lo

// 二分探索ライブラリ
class Bsearch[T: Ordering](val a: ArrayBuffer[T]):
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

// 位置を現すEnum
// Bottom .. エレベータの最下部
// Top .. エレベータの最上部
// Mid .. どちらでもない
enum Position:
  case Bottom, Top, Mid

// イベントソート用
case class Event(lo: Long, pos: Position, hi: Long) extends Ordered[Event]:
  override def compare(that: Event): Int =
    if this.lo == that.lo then
      if this.pos == that.pos then
        (this.hi - that.hi).toInt
      else
        (this.pos.ordinal - that.pos.ordinal).toInt
    else
      (this.lo - that.lo).toInt


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
    (ArrayBuffer.empty[Elevator] ++= nex).sorted

  // 全エレベータの下階、上階をまとめてイベント列とキーを作る
  var keys = Stack.empty[Long]
  var events = Stack.empty[Event]

  for
    elevators <- compressed_buildings
    elevator <- elevators
  do
    keys.push(elevator.lo)
    keys.push(elevator.hi)
    events.push(Event(elevator.lo, Position.Bottom, elevator.hi))
    events.push(Event(elevator.hi, Position.Top, elevator.hi))
  
  // クエリを先読みして、キーには乗り降り階を含めておく
  val queries = for
    _ <- 0 until q
  yield
    val line = io.StdIn.readLine().split(" ").map(_.toLong)
    val x = line(0).toInt - 1
    val y = line(1)
    val z = line(2).toInt - 1
    val w = line(3)

    keys.push(y)
    keys.push(w)
    events.push(Event(y, Position.Mid, 0L))
    events.push(Event(w, Position.Mid, 0L))
    if y <= w then
      ((x, y, z, w))
    else
      ((z, w, x, y))
  
  // 座標圧縮
  val cc = CoodinateCompress(keys.toArray)

  // dpテーブルを埋める
  // dp[keyのi番目にいるとき][あと2^j回で] := たどり着けるkeyのindex
  var dp = ArrayBuffer.fill(cc.src.length,20)(0)

  // まずは(1)j=0をdpで求める
  var maxi = 0L
  for
    Event(lo, pos, hi) <- events.sorted
  do
    pos match
      case Position.Bottom => if maxi < hi then maxi = hi
      case Position.Top =>
      case Position.Mid => if maxi < lo then maxi = lo
    dp(cc(lo))(0) = cc(Math.max(lo, maxi))

  // (2)ダブリング
  for
    j <- 1 until 20
    i <- 0 until cc.src.length
  do
    dp(i)(j) = dp(dp(i)(j-1))(j-1)

  // ここまでくればもう一息、dpテーブルを利用して以下の通り
  // 回数を0にセット
  // 現在の階 < ゴールの階である間
  //  | 2^19回移動 < ゴール = 答えなし
  //  | 1回移動 >= ゴール = 回数 + 1が答え
  //  | 1回移動 < ゴールなので
  //  | 2分探索でゴールを越えない移動回数の最大のjを求める
  //  | 回数に2^jを加える、現在の階をdp[現在の階][j]に変更
  //
  // 最初から、現在 <= ゴールにしておく
  // コーナーケースは事前に排除
  // 現在の階 => 現在のビルで登れる最大にしておく
  // ゴール => ゴールのビルの一番下にしておく
  // 現在 > ゴールなら、同じビルなら+0, 違うなら+1

  for
    (x,_y,z,_w) <- queries
  do
    var y = _y
    var w = _w
    var ans = w - y
    
    // ビルx内のy階から乗れるエレベータを探して一番上へ
    // 乗れる == 上の階が自分以上
    for elevator <- Bsearch(compressed_buildings(x)).solve(e => e.hi >= y) do
      if elevator.lo <= y then y = elevator.hi
    
    // ビル内のw階から乗れるエレベータを探して一番下へ
    for elevator <- Bsearch(compressed_buildings(z)).solve(e => e.hi >= w) do
      if elevator.lo <= w then w = elevator.lo

    if y >= w then
      println(ans + (if x != z then 1 else 0))
    else
      var i = cc(y)
      var j = cc(w)

      if dp(i).last < j then
        println(-1)
      else
        var flag = true
        while i < j && flag do
          if dp(i)(0) >= w then
            println(ans + 2)
            flag = false
          else
            for
              jj <- (0 until 20).toArray.collectFirst { case k if j <= dp(i)(k) => k }
            do
              ans += (1L << jj)
              i = dp(i)(jj)
