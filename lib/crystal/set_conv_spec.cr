require "spec"
require "crystal/set_conv"

describe SetConv do
  it "usage" do
    # sc = SetConv(Int32).new { |x, y| Math.max(x, y) }
    # sc.zeta([1,2,3,4]).should eq [1,2,3,4]
    # sc.zeta([5,8,6,7]).should eq [5,8,6,8]
    # sc.moebius([6,10,9,12]).should eq [6,8,9,12]
    # sc.conv([1, 2, 3, 4], [5, 8, 6, 7]).should eq [6, 10, 9, 12]
  end

  it "set conv" do
    sc = SetConv(Set(Int32)).new { |x, y| x + y }
    pp sc.zeta([Set{1},Set{2},Set{3},Set{4}])
  end
end
