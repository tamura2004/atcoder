require "spec"
require "crystal//fft"

describe "FFT" do
  it "usage" do
    a = [1, 2, 3]
    b = [4, 3, 2]
    conv(a, b).should eq [4, 11, 20, 13, 6]
  end
end
