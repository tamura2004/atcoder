require "crystal/dfa"

record ModInt, v : Int64 do
  MOD = 10 ** 9 + 7
  def +(b); ModInt.new (v + b.to_i64) % MOD; end
  def -(b); ModInt.new (v - b.to_i64) % MOD; end
  def self.zero; new(0); end
  def to_i64; v; end
  delegate to_s, inspect, to: v
end

class DigitSumMultipleOf(T) < DFA(Int32,Int32,T)
  getter m : Int32

  def initialize(@m)
    @init = 0
    @nex = ->(s : Int32, d : Int32, i : Int32) {
      (s + d) % m
    }
    @accept = ->(s : Int32) { s.zero? }
    @ok = ->(s : Int32) { false }
    @ng = ->(s : Int32) { false }
  end
end

# main
a = gets.to_s.chars.map(&.to_i)
m = gets.to_s.to_i
n = a.size

dsmo = DigitSumMultipleOf(ModInt).new(m)
leq = LEQ(ModInt).new(a)

D = (0..9).to_a
ans = (dsmo + leq).count(n, D)

pp ans - 1
