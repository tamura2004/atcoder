require "spec"
require "crystal/indexable"

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

  it "ソート済の配列に対し、*u*以下の上限のindexを返す" do
    a = [1,3,5,5,5,7,7,9]
    a.upper_bound(0).should eq -1
    a.upper_bound(1).should eq 0
    a.upper_bound(2).should eq 0
    a.upper_bound(3).should eq 1
    a.upper_bound(4).should eq 1
    a.upper_bound(5).should eq 4
    a.upper_bound(6).should eq 4
    a.upper_bound(7).should eq 6
    a.upper_bound(8).should eq 6
    a.upper_bound(9).should eq 7
    a.upper_bound(10).should eq 7
    a.upper_bound(0, eq: false).should eq -1
    a.upper_bound(1, eq: false).should eq -1
    a.upper_bound(2, eq: false).should eq 0
    a.upper_bound(3, eq: false).should eq 0
    a.upper_bound(4, eq: false).should eq 1
    a.upper_bound(5, eq: false).should eq 1
    a.upper_bound(6, eq: false).should eq 4
    a.upper_bound(7, eq: false).should eq 4
    a.upper_bound(8, eq: false).should eq 6
    a.upper_bound(9, eq: false).should eq 6
    a.upper_bound(10, eq: false).should eq 7

    b = [-100, 100, 1000]
    b.upper_bound(50).should eq 0 
  end

  it "ソート済の配列に対し、*u*以上の下限のindexを返す" do
    a = [1,3,5,5,5,7,7,9]
    a.lower_bound(0).should eq 0
    a.lower_bound(1).should eq 0
    a.lower_bound(2).should eq 1
    a.lower_bound(3).should eq 1
    a.lower_bound(4).should eq 2
    a.lower_bound(5).should eq 2
    a.lower_bound(6).should eq 5
    a.lower_bound(7).should eq 5
    a.lower_bound(8).should eq 7
    a.lower_bound(9).should eq 7
    a.lower_bound(10).should eq 8
    a.lower_bound(0, eq: false).should eq 0
    a.lower_bound(1, eq: false).should eq 1
    a.lower_bound(2, eq: false).should eq 1
    a.lower_bound(3, eq: false).should eq 2
    a.lower_bound(4, eq: false).should eq 2
    a.lower_bound(5, eq: false).should eq 5
    a.lower_bound(6, eq: false).should eq 5
    a.lower_bound(7, eq: false).should eq 7
    a.lower_bound(8, eq: false).should eq 7
    a.lower_bound(9, eq: false).should eq 8
    a.lower_bound(10, eq: false).should eq 8
  end

  it "ソート済の配列に対し、範囲*r*に含まれる要素数を返す" do
    a = [1,3,5,7,9]
    a.count_range(3..7).should eq 3
    a.count_range(..4).should eq 2
    a.count_range(4..).should eq 3
    a.count_range(4..10).should eq 3
    a.count_range(0..10).should eq 5
  end

  it "cs" do
    [1,2,3].cs.should eq [0,1,3,6]
  end

  it "range sum" do
    [1,2,3].cs.range_sum(0..1).should eq 3
    [1,2,3].cs.range_sum(1..2).should eq 5
    [1,2,3].cs.range_sum(..1).should eq 3
    [1,2,3].cs.range_sum(1..).should eq 5
    [1,2,3].cs.range_sum(0...2).should eq 3
    [1,2,3].cs.range_sum(0...).should eq 6
    [1,2,3].cs.range_sum(...2).should eq 3
    [1,2,3].cs.range_sum(-100..1).should eq 3
    [1,2,3].cs.range_sum(-100..100).should eq 6
    [1,2,3].cs.range_sum(..100).should eq 6
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

  it "csmin" do
    a = [5,2,4,3]
    a.csmin(head: false).should eq [5,2,2,2]
  end

  it "csmax" do
    a = [1,3,2,4]
    a.csmax(head: false).should eq [1,3,3,4]
  end
end