# 有限決定性オートマトンによる桁DP抽象化
# S : 状態
# W : 語
# Z : 件数
class DFA(S, W, Z)
  getter init : S
  getter nex : Proc(S, W, Int32, S)
  getter accept : Proc(S, Bool)
  getter ok : Proc(S, Bool)
  getter ng : Proc(S, Bool)

  def initialize(@init, @nex, @accept, @ok, @ng)
  end

  def +(b : DFA(T, W, Z)) forall T
    DFA(Tuple(S, T), W, Z).new(
      init: {init, b.init},
      nex: ->(st : Tuple(S, T), d : W, i : Int32) {
        s, t = st
        {nex.call(s, d, i), b.nex.call(t, d, i)}
      },
      accept: ->(st : Tuple(S, T)) {
        s, t = st
        accept.call(s) && b.accept.call(t)
      },
      ok: ->(st : Tuple(S, T)) {
        s, t = st
        ok.call(s) && b.ok.call(t)
      },
      ng: ->(st : Tuple(S, T)) {
        s, t = st
        ng.call(s) || b.ng.call(t)
      },
    )
  end

  def count(n : Int32, digits : Array(W), plus : Proc(Z, Z, Z) = Proc(Z, Z, Z).new { |a, b| a + b })
    dp = Hash(S, Z).new(Z.zero)
    dp2 = Hash(S, Z).new(Z.zero)
    dp[init] = Z.zero + 1

    n.times do |i|
      dp.each do |s, cnt|
        digits.each do |d|
          ss = nex.call(s, d, i)
          next if ng.call(ss)
          dp2[ss] = plus.call dp2[ss], cnt
        end
      end
      dp2, dp = dp, dp2
      dp2.clear
    end

    dp.sum do |s, cnt|
      accept.call(s) ? cnt : Z.zero
    end
  end
end

class LEQ(T) < DFA(Int32,Int32,T)
  getter a : Array(Int32)

  def initialize(@a)
    @init = 0
    @nex = ->(s : Int32, d : Int32, i : Int32) { s != 0 ? s : d <=> a[i] }
    @accept = ->(s : Int32) { s != 1 }
    @ok = ->(s : Int32) { s == -1 }
    @ng = ->(s : Int32) { s == 1 }
  end
end
