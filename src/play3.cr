require "crystal/static_mod_int"
require "crystal/matrix"

MOD = 1000000000
alias Modint = StaticModInt(MOD)

struct Int
  def to_m
    Modint.new(to_i64)
  end
end

m = Matrix(Int32).new([
  [0,1],
  [1,1]
]).map(&.to_m)

n = gets.to_s.to_i64

ans = (m ** n)[0,1]
pp ans
