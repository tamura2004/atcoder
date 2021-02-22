require "spec"
require "../segment_tree"

alias X = Tuple(Int32, Int32)

describe SegmentTree do
  it "basic usage" do
    v = Array(X).new(3){ X.new 0, 1 }
    obj = SegmentTree(X).new(v) do |(a0,a1), (b0,b1)|
      X.new a0 * b0, a1 * b0 + b1
    end

    obj[0] = X.new 2, 1
    obj[1] = X.new 3, 2
    obj[2] = X.new 4, 3
    obj[0, 3].should eq X.new(24,23)
  end
end
