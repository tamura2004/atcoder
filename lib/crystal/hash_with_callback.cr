# コールバック付きカウンター
#
# 与えられたキーに対してカウントを保持するクラス
# カウントが1から0になったときにoffコールバックを呼ぶ
# カウントが0から1になったときにonコールバックを呼ぶ
#
# ```
# ct = HashWithCallback.new(
#   on: ->(k : Int64) { puts "on #{k}" },
#   off: ->(k : Int64) { puts "off #{k}" })
# )
# ct.inc(1) # => on 1
# ct.dec(1) # => off 1
# ```
class HashWithCallback
  getter h : Hash(Int64, Int64)
  getter on : Proc(Int64, Nil)
  getter off : Proc(Int64, Nil)
  delegate "[]", "[]=", to: h

  def initialize(@on, @off)
    @h = Hash(Int64, Int64).new(0_i64)
  end

  def inc(k : Int64)
    on.call(k) if h[k].zero?
    h[k] += 1
  end

  def dec(k : Int64)
    h[k] -= 1
    off.call(k) if h[k].zero?
  end
end
