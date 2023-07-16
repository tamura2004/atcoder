case class ModInt(_v : Long) {
  val MOD = 998244353L
  val v = (_v + MOD) % MOD
  def +(b : ModInt) = new ModInt(v + b.v)
  def +(b : Long) = new ModInt(v + b)
  def *(b : ModInt) = new ModInt(v * b.v)
  def *(b : Long) = new ModInt(v * b)
  def toLong = v
  override def toString = v.toString
}
