require "spec"
require "crystal/f2/matrix"
include F2

describe F2::Matrix do
  it "usage" do
    a = [
      0b1101,
      0b0111,
      0b1011
    ]
    m = Matrix(Int32).new(a)
    m.debug(4)
    m.sweep
    m.debug(4)
  end
end
