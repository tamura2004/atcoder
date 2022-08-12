require "crystal/static_mod_int"
MOD = 998_244_353_i64
alias ModInt = StaticModInt(MOD)

struct Int
  def to_m
    ModInt.new(to_i64)
  end
end
