# require "crystal/dfa"
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

  def not
    DFA(S,W,Z).new(
      init: init,
      nex: nex,
      accept: ->(s : S) { !accept.call(s) },
      ok: ->(s : S) { ng.call(s) },
      ng: ->(s : S) { ok.call(s) },
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

# a以下の数
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

# a未満の数
class LT(T) < DFA(Int32,Int32,T)
  getter a : Array(Int32)

  def initialize(@a)
    @init = 0
    @nex = ->(s : Int32, d : Int32, i : Int32) { s != 0 ? s : d <=> a[i] }
    @accept = ->(s : Int32) { s == -1 }
    @ok = ->(s : Int32) { s == -1 }
    @ng = ->(s : Int32) { s == 1 }
  end
end

# mの倍数
class MultipleOf(T) < DFA(Int32,Int32,T)
  getter m : Int32

  def initialize(@m)
    @init = 0
    @nex = ->(s : Int32, d : Int32, i : Int32) { (s * 10 + d) % m }
    @accept = ->(s : Int32) { s == 0 }
    @ok = ->(s : Int32) { false }
    @ng = ->(s : Int32) { false }
  end
end

class ZigZag(T) < DFA(Tuple(Int32,Int32),Int32,T)
  NONE = 0
  INIT = 1
  FIRS = 2
  INCR = 3
  DECR = 4

  def initialize
    @init = {INIT,-1}
    @nex = ->(sv : Tuple(Int32,Int32),d : Int32, i : Int32) {
        s,v = sv
        ss = case s
        when INIT
          d.zero? ? INIT : FIRS
        when FIRS then v == d ? NONE : v < d ? INCR : DECR
        when INCR then v > d ? DECR : NONE
        when DECR then v < d ? INCR : NONE
        else
          NONE
        end
        {ss, d}
    }
    @accept = -> (sv : Tuple(Int32,Int32)) {
      sv[0] != NONE
    }
    @ok = -> (sv : Tuple(Int32,Int32)) {
      sv[0] != NONE
    }
    @ng = -> (sv : Tuple(Int32,Int32)) {
      sv[0] == NONE
    }
  end
end

class NOP(T) < DFA(Int32,Int32,T)
  def initialize
    @init = 0
    @nex = ->(s : S, d : Int32, i : Int32) { s }
    @accept = -> (s : S) { true }
    @ok = -> (s : S) { true }
    @ng = -> (s : S) { false }
  end
end

record ModInt, v : Int64 do
  MOD = 10 ** 9 + 7
  def +(b); ModInt.new (v + b.to_i64) % MOD; end
  def -(b); ModInt.new (v - b.to_i64) % MOD; end
  def self.zero; new(0); end
  def to_i64; v; end
  delegate to_s, inspect, to: v
end