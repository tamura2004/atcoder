require "spec"
require "crystal//poly"

describe Poly do
  it "usage" do
    po = Poly.new
    po << ({1, 3})
    po << ({3, 3})
    po.clip
    po.a.should eq Set{({0, 0}), ({2, 0})}
    po.w.should eq 3
    po.h.should eq 1

    po.rot90
    po.a.should eq Set{({0, 0}), ({0, 2})}
    po.w.should eq 1
    po.h.should eq 3

    po + ({2, 3})

    po.a.should eq Set{({2, 3}), ({2, 5})}
    po.w.should eq 1
    po.h.should eq 3
  end
end
