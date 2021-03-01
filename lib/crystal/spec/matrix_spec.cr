require "spec"
require "../matrix"

describe Matrix do
  it "usage" do
    a = Matrix(Int32).new([
      [1,1],
      [1,0]
    ])
    b = Matrix(Int32).new([
      [8,5],
      [5,3]
    ])
    (a*a*a*a*a).should eq b
    (a**5).should eq b
  end
end
