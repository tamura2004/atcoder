require "spec"
require "crystal/coodinate_compress_liner"

describe CCL do
  it "usage" do
    cc = CCL.new
    cc << 100
    cc << -10
    cc << 5
    cc << -10

    cc.commit!

    cc.size.should eq 3

    cc.src.should eq [100, -10, 5, -10]
    cc.ix.should eq ({-10 => 0, 5 => 1, 100 => 2})
    cc.val.should eq [-10, 5, 100]

    cc[-10].should eq 0
    cc[5].should eq 1
    cc[100].should eq 2
    # 値からインデックスへ
    cc.ix[-10].should eq 0
    cc.ix[5].should eq 1
    cc.ix[100].should eq 2
    # インデックスから値へ
    cc.val[0].should eq -10
    cc.val[1].should eq 5
    cc.val[2].should eq 100
  end

  it "init by array" do
    cc = CCL.new([100,-10,5,-10])

    cc[-10].should eq 0
    cc[5].should eq 1
    cc[100].should eq 2
  end
end
