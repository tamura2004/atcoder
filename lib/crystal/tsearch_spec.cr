require "spec"
require "crystal/tsearch"

values_1 = [100,40,40,20,25,30,70]
values_2 = [100,40,40,20]
values_3 = [20,25,30,70]

describe "三分探索" do
  it "インデックスを取得" do
    (0..6).tsearch_index{|i|values_1[i]}.should eq 3
    (0..3).tsearch_index{|i|values_2[i]}.should eq 3
    (0..3).tsearch_index{|i|values_3[i]}.should eq 0
  end

  it "値を取得" do
    (0..6).tsearch{|i|values_1[i]}.should eq 20
    (0..3).tsearch{|i|values_2[i]}.should eq 20
    (0..3).tsearch{|i|values_3[i]}.should eq 20
  end
end
