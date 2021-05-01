require "spec"
require "../lucas"

describe Lucas do
  it "usage" do
    lc = Lucas.new(3)
    lc.combi(26,13).should eq 2
  end
end