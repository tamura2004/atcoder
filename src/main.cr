class DFA(S, W)
  getter init : S
  getter nex : Proc(S, W, Int32, S)
  getter ok : Proc(S, Bool)
  getter good : Proc(S, Bool)
  getter bad : Proc(S, Bool)

  def initialize(
    @init : S,
    @nex : Proc(S, W, Int32, S),
    @ok : Proc(S, Bool),
    @good : Proc(S, Bool) = ->(s : S) { false },
    @bad : Proc(S, Bool) = ->(s : S) { false }
  )
  end

  def +(b : DFA(T, W)) forall T
    DFA.new(
      init: {init, b.init},
      nex: Proc(Tuple(S, T),W,Int32,Tuple(S, T)).new do |(s,t),d,i|
        ({nex.call(s, d, i), b.nex.call(t, d, i)})
      end,
      ok: Proc(Tuple(S, T),Bool).new do |(s,t)|
        ok.call(s) && b.ok.call(t)
      end,
      good: Proc(Tuple(S, T),Bool).new do |(s,t)|
        good.call(s) && b.good.call(t)
      end,
      bad: Proc(Tuple(S, T),Bool).new do |(s,t)|
        bad.call(s) || b.bad.call(t)
      end,
    )
  end

  def count(n : Int32, words : Array(W), mod = 1_000_000_007_i64)
    dp = Hash(S, Int64).new(0_i64)
    dp2 = Hash(S, Int64).new(0_i64)
    dp[init] = 1_i64

    n.times do |i|
      dp.each do |state, count|
        words.each do |d|
          nex_state = nex.call(state, d, i)
          break if bad.call(nex_state)
          dp2[nex_state] += count
          dp2[nex_state] %= mod
        end
      end

      dp, dp2 = dp2, dp
      dp2.clear
    end

    dp.sum do |state, count|
      ok.call(state) ? count : 0_i64
    end
  end
end

enum Ordering
  Less    = -1
  Equal   =  0
  Greater =  1

  def then(b : Ordering)
    self == Ordering::Equal ? b : self
  end

  def then(b : Int32)
    self.then(Ordering.new(b))
  end
end

m = gets.to_s.to_i
a = gets.to_s.chars.map(&.to_i)
n = a.size

leq = DFA(Ordering, Int32).new(
  init: Ordering::Equal,
  nex: Proc(Ordering,Int32,Int32,Ordering).new do |s,d,i|
    s.then(d <=> a[i])
  end,
  ok: Proc(Ordering, Bool).new do |s|
    s != Ordering::Greater
  end,
  good: Proc(Ordering, Bool).new do |s|
    s == Ordering::Less
  end,
  bad: Proc(Ordering,Bool).new do |s|
    s == Ordering::Greater
  end,
)

digit_sum = DFA(Int32, Int32).new(
  init: 0,
  nex: Proc(Int32,Int32,Int32,Int32).new do |s,d,i|
    (s + d) % m
  end,
  ok: Proc(Int32,Bool).new do |s|
    s.zero?
  end,
  good: Proc(Int32,Bool).new do |s|
    true
  end,
  bad: Proc(Int32,Bool).new do |s|
    false
  end
)

digit = (0..9).to_a
ans = (leq + digit_sum).count(n, digit)
pp (ans - 1) % 1_000_000_007_i64
