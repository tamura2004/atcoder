require "spec"
require "../lib/crystal/ntt_convolution"

describe "ceil_pow2" do
  it "return" do
    ceil_pow2(10).should eq 4
    ceil_pow2(2**10).should eq 10
    ceil_pow2(2**10 - 1).should eq 10
  end
end

describe "primitive_root" do
  it "return" do
    primitive_root(10**9+7).should eq 5
    primitive_root(754974721).should eq 11
  end
end

include Random::Secure

MOD = 998244353
N = 100

describe "convolution" do
  it "should eq mini" do
      a = Array.new(N) { rand(0..MOD - 1).to_i64 }
      b = Array.new(N) { rand(0..MOD - 1).to_i64 }
      c = a.dup
      d = b.dup
      convolution(a,b,MOD).should eq convolution_mini(c,d,MOD)
  end
end




# 10.times do
#   g = a.dup
#   h = b.dup
#   e = convolution(a, b, MOD)
#   f = convolution_mini(c, d, MOD)
#   if e != f
#     pp! g
#     pp! h
#     pp! e
#     pp! f
#     raise "result mismatch"
#   end
# end
