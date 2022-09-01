require "spec"
require "crystal//symmetric_group"

describe SymmetricGroup do
  it "usage" do
    x = S.new [1,2,0,3]
    y = S.new [0,2,3,1]
    z = S.new [1,2,3,0]
    puts x
    puts y
    puts z * x * -z
  end
end
