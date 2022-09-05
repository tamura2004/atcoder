require "spec"
require "crystal/persistent_array"

describe PersistentArray do
  it "usage" do
    a = PersistentArray(Int32).new
    a[0].should eq 0
    a[1].should eq 1
    a1 = a.update(0, 2)
    a2 = a1.update(1, 3)
    a[0].should eq 0
    a[1].should eq 1
    a1[0].should eq 2
    a1[1].should eq 1
    a2[0].should eq 2
    a2[1].should eq 3
    a1[1] = 12
    a1[100] = 13
    a1[1000000] = 14
    a1[1].should eq 12
    a1[100].should eq 13
    a1[1000000].should eq 14
  end
end
