require "spec"
require "../indexable"

describe Indexable do
  it "ソート済の配列に対し*u*未満の要素数を返す" do
    a = [2,4]
    a.count_less(1).should eq 0
    a.count_less(2).should eq 0
    a.count_less(3).should eq 1
    a.count_less(4).should eq 1
    a.count_less(5).should eq 2
  end

  it "ソート済の配列に対し*u*以下の要素数を返す" do
    a = [2,4]
    a.count_less_or_equal(1).should eq 0
    a.count_less_or_equal(2).should eq 1
    a.count_less_or_equal(3).should eq 1
    a.count_less_or_equal(4).should eq 2
    a.count_less_or_equal(5).should eq 2
  end

  it "ソート済の配列に対し*u*を越える要素数を返す" do
    a = [2,4]
    a.count_more(1).should eq 2
    a.count_more(2).should eq 1
    a.count_more(3).should eq 1
    a.count_more(4).should eq 0
    a.count_more(5).should eq 0
  end

  it "ソート済の配列に対し*u*以上の要素数を返す" do
    a = [2,4]
    a.count_more_or_equal(1).should eq 2
    a.count_more_or_equal(2).should eq 2
    a.count_more_or_equal(3).should eq 1
    a.count_more_or_equal(4).should eq 1
    a.count_more_or_equal(5).should eq 0
  end

  it "cs" do
    [1,2,3].cs.should eq [0,1,3,6]
  end

  it "csr" do
    [1,2,3].csr.should eq [6,5,3,0]
  end

  it "csb" do
    [1,2,3].csb.should eq [5,4,3]
  end

  it "or" do
    [0b011,0b110].or.should eq 0b111
  end

  it "idx" do
    [2,0,1].idx.should eq [1,2,0]
  end

  it "tally" do
    a = [2,2,1,2,2]
    b = a.tally
    b[0].should eq 0
    b[2].should eq 4
    b[2].class.should eq Int64
  end

  it "compress" do
    a = [1,1,200,1]
    a.compress.should eq [0,0,1,0]
  end
end