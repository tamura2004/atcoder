require "spec"
require "crystal/ntt_convolution"

describe "convolution" do
  # (2 + 3x)(4 + 5x) = 8 + 22x + 15x^2
  it "usage" do
    a = [2, 3]
    b = [4, 5]
    convolution(a, b).should eq [8, 22, 15]
  end

  # it "random test" do
  #   10.times do
  #     a = Array.new(100) { rand(100000000i64) }
  #     b = Array.new(100) { rand(100000000i64) }
  #     e = convolution(a, b)
  #   end
  # end
end
