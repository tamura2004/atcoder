require "spec"
require "crystal/cht"

describe CHT do
  it "usage" do
    cht = CHT.new
    cht << Line.new(3, 0)
    cht << Line.new(-3, 9)

    cht.min(1).should eq 3
    cht.min(2).should eq 3

    cht << Line.new(0, 4) # 係数が整数の場合は追加されない
    cht.size.should eq 2

    cht << Line.new(0, 2)
    cht.size.should eq 3

    cht.min(1).should eq 2
    cht.min(2).should eq 2

    cht << Line.new(-1, 2)
    cht.min(3).should eq -1
  end

  it "not overflow" do
    line1 = Line.new(1e9.to_i64, 1e18.to_i64-1)
    line2 = Line.new(1e9.to_i64-1, 1e18.to_i64)
    line1.cross(line2).should eq 1_i64
    line1[1e9.to_i64].should eq 1e18.to_i64 * 2 - 1
  end
end
