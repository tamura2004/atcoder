require "spec"
require "../ntt_convolution"

MOD = 998244353
N   =       100

describe "convolution" do
  # (2x + 3)(4x + 5) = 8x^2 + 22x + 15
  it "usage" do
    a = [2, 3].map &.to_i64
    b = [4, 5].map &.to_i64
    convolution(a, b, MOD).should eq [8, 22, 15]
  end

  it "random test" do
    10.times do
      a = Array.new(N) { rand(0..MOD - 1).to_i64 }
      b = Array.new(N) { rand(0..MOD - 1).to_i64 }
      c = a.dup
      d = b.dup
      g = a.dup
      h = b.dup
      e = convolution(a, b, MOD)
      f = convolution_mini(c, d, MOD)
      e.should eq f
    end
  end
end
