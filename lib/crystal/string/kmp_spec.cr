require "spec"
require "crystal/string/kmp"

describe Kmp do
  it "usage" do
    Kmp.new("abcabc").repeat_size.should eq [1, 1, 2, 3, 3, 3, 3]
  end
end
