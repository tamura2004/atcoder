require "spec"
require "crystal/abc258"
include Abc258

describe Abc258 do
  it "usage" do
    pr = A.new(3,[1,2,3])
    pr.solve.should eq 2.0
  end
end
