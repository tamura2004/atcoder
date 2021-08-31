require "spec"
require "../ntt_convolution"

N   =       100

describe "convolution" do
  # (2 + 3x)(4 + 5x) = 8 + 22x + 15x^2
  it "usage" do
    a = [2, 3].map &.to_i64
    b = [4, 5].map &.to_i64
    convolution(a, b).should eq [8, 22, 15]
  end

  it "random test" do
    10.times do
      a = Array.new(N) { rand(0..MOD - 1).to_i64 }
      b = Array.new(N) { rand(0..MOD - 1).to_i64 }
      c = a.dup
      d = b.dup
      g = a.dup
      h = b.dup
      e = convolution(a, b)
    end
  end
end
