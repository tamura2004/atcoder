require "colorize"

macro define_mod(*nums)
  {% for num in nums %}
    module M{{num}}
      MOD = {{num}}_i64
    end
  {% end %}
end

define_mod 2, 3, 5, 7, 11, 17, 1_000_000_007

module Mod
  MOD = 10_i64**9+7
end

struct ModInt(T)
  getter v : Int64
  forward_missing_to v

  def initialize(@v = 0_i64)
  end

  def self.zero
    new
  end

  def +(other : self)
    (v + other.v) % T::MOD
  end
end

x = ModInt(Mod).new(1_000_000_000_i64)
y = ModInt(Mod).new(1_000_000_000_i64)

def warn(str)
  puts str.colorize(:red)
end

warn x + y
