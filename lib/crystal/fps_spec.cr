require "spec"
require "crystal/fps"

describe FPS do
  it "usage" do
    FPS.new([1,1]).inv.should eq FPS.new([1,MOD - 1])
  end
end
