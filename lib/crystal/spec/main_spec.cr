require "spec"
require "../../../src/main"

describe "main" do
  it "cyclic compress" do
    compress([] of Int32).should eq [] of Tuple(Int32,Int32)
    compress([1]).should eq [{1, 1}]
    compress([1, 1, 1, 1, 1]).should eq [{1, 5}]
    compress([1, 1, 1, 2, 2, 1, 1]).should eq [{1, 5}, {2, 2}]
    compress([1, 1, 1, 2, 2, 2]).should eq [{1, 3}, {2, 3}]
  end
end
