require "spec"
require "crystal/string/manacher"

describe "Manacher" do
  it "usage" do
    "iwi".manacher.should eq [1, 2, 1]
  end

  it "偶数長の回分の場合、ダミーを挟む" do
    "b@a@a@b".manacher.should eq [1, 1, 2, 4, 2, 1, 1]
  end
end
