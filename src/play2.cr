require "crystal/xor_base"

a = [
  0b101110,
  0b001010,
  0b010100,
  0b100010
]

xb = XorBase.new(a).sweep!
pp xb.base.map(&.to_s(2))
