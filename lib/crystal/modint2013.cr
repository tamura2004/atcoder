require "crystal/static_mod_int"
MOD = 2013265921_i64
ROOT = 31
alias ModInt = StaticModInt(MOD)

struct Int
  def to_m
    ModInt.new(self)
  end

  def inv
    ModInt.new(self).inv
  end

  def pow(b)
    ModInt.new(self) ** b
  end
end
