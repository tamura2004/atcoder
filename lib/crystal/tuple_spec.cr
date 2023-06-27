require "spec"
require "crystal//tuple"

describe Tuple do
  it "usage" do
    (({1, 2}) + ({3, 4})).should eq ({4, 6})
    (({1, 2}) - ({3, 4})).should eq ({-2, -2})
    (({1, 2}) * ({3, 4})).should eq ({3, 8})
    (({1, 2}) // ({3, 4})).should eq ({0, 0})
  end
end
