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
end