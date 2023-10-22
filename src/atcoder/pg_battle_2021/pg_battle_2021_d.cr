# a : Indexable(T)がコンストラクタのパラメータで与えられたとき
# self[e : T, i : Int32] : Int32? で、位置i以降で最初にeが出現する位置を返す
# 位置iの要素がeであればiを返す（iを含む）
# 出現しないならnil
# また、要素長 <= iならnilを返す
# repeat引数が指定されていた場合、aをrepeat回数繰り返したものとして扱う
class Nex(T)
  private getter a : Indexable(T)
  private getter n : Int32
  private getter repeat : Int32
  private getter nex : Array(Hash(T, Int32))

  def initialize(@a, @repeat = 1)
    @n = @a.size
    @nex = a.zip(0..).map do |e, i|
      {e => i}
    end.reverse.reduce([{} of T => Int32]) do |acc, b|
      acc << acc[-1].merge(b)
    end.reverse
  end

  # aの長さnで商と余りを取りq,rとする
  # r以降に出現位置iがあれば、q * n + iが答え
  # 無ければ、0以降の出現位置iを求めて、(q + 1) * n + iが答え
  # 最後に、答えがrepeat * n以上であればnil
  def [](e : T, i : Int32) : Int32?
    q, r = i.divmod(n)
    (nex[r][e]?.try(&.+ q * n) || nex[0][e]?.try(&.+ q.succ * n)).try do |ans|
      ans < n * repeat ? ans : nil
    end
  end
end

n = gets.to_s.to_i64
a = gets.to_s.split.map(&.to_i64)
s = gets.to_s.split.map(&.to_i64)
nex = Nex.new(a)
pp nex[1,1]

