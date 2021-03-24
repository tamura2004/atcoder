# ロー法により途中からループする状態遷移の値を求める
class Ro(T)
  N = 1_000_000 # ループ長さ上限

  getter f : Proc(T, T)       # 遷移関数
  getter idx : Hash(T, Int32) # 値->インデックス
  getter val : Hash(Int32, T) # インデックス->値

  def initialize(&@f : Proc(T, T))
    @idx = Hash(T, Int32).new
    @val = Hash(Int32, T).new
  end

  # ループの開始点と終了点を求める。
  # 合わせて終了点までの値を*dp*にメモ
  def rec(x : T)
    N.times do |i|
      if pre = idx[x]?
        return pre, i
      else
        idx[x] = i
        val[i] = x
      end
      x = f.call(x)
    end
    raise "ループが閉じません"
  end

  # 初期状態*x*に対し*k*回*f*を適用した時の値を求める
  #
  # kがループ開始未満であればそのまま適用
  # kがループ中であれば、ループ長の剰余から求める
  def solve(x : T, k : Int64)
    lo, hi = rec(x)
    i = k < lo ? k.to_i : (k - lo) % (hi - lo) + lo
    val[i]
  end
end
