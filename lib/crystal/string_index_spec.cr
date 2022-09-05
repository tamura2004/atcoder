require "spec"
require "crystal/string_index"

describe StringIndex do
  it "usage" do
    dp = StringIndex.new("abcdabcd")
    dp['b'].should eq 1
    dp['b',1].should eq 1
    dp['b',2].should eq 5
    dp['b',6].should eq nil
  end
end
