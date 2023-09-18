require "spec"
require "crystal//nex"

# 事前計算ありの高速なindex
describe Nex do
  it "指定位置以降の最初の出現位置を返す" do
    nex = Nex.new([3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5])
    #              0  1  2  3  4  5  6  7  8  9  10
    # 3が位置0以降に出現するのは位置0
    nex[3, 0].should eq 0
    nex[1, 0].should eq 1
    nex[4, 0].should eq 2
    nex[5, 0].should eq 4

    # 3が位置5以降に出現するのは位置9
    nex[3, 5].should eq 9
    nex[1, 5].should eq nil
    nex[4, 5].should eq nil
    nex[5, 5].should eq 8

    # 3は位置10の次に出現しない
    nex[3, 10].should eq nil
    nex[1, 10].should eq nil
    nex[4, 10].should eq nil
    nex[5, 10].should eq 10

    # 位置100以降は何もない
    nex[3, 100].should eq nil
    nex[1, 100].should eq nil
    nex[4, 100].should eq nil
    nex[5, 100].should eq nil
  end

  it "繰り返し回数を指定できる" do
    nex = Nex.new([3, 1, 4, 1], 2)
    #              0  1  2  3
    #              4  5  6  7

    nex[3, 0].should eq 0
    nex[1, 0].should eq 1
    nex[4, 0].should eq 2

    nex[3, 2].should eq 4
    nex[1, 2].should eq 3
    nex[4, 2].should eq 2

    nex[3, 6].should eq nil
    nex[1, 6].should eq 7
    nex[4, 6].should eq 6

    nex[3, 8].should eq nil
    nex[1, 8].should eq nil
    nex[4, 8].should eq nil
  end

  it "ハッシュ可能な要素であれば良い" do
    nex = Nex.new("abcabcabcdef".chars)
    nex['a', 0].should eq 0
    nex['d', 5].should eq 9
    nex['d', 10].should eq nil
  end
end
