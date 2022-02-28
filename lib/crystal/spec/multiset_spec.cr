require "spec"
require "crystal/multiset"

describe RBST do
  it "init nil tree" do
    t = RBST(Int32).new
    t.nil_tree?.should eq true
    t.size.should eq 0
  end

  it "init tree" do
    t = RBST{1,2,3}
    t.nil_tree?.should eq false
    t.size.should eq 3
  end
  
  it "merge" do
    left = RBST{1,2,3}
    right = RBST{4,5,6}
    left.merge(right).size.should eq 6
  end
  
  it "includes?" do
    t = RBST{1,2,3}
    t.includes?(0).should eq nil
    t.includes?(1).should eq true
    t.includes?(2).should eq true
    t.includes?(3).should eq true
    t.includes?(4).should eq nil
  end
  
  it "upper eq" do
    t = RBST{1,2,3}
    t.upper(0).should eq 1
    t.upper(1).should eq 1
    t.upper(2).should eq 2
    t.upper(3).should eq 3
    t.upper(4).should eq nil
  end
  
  it "upper" do
    t = RBST{1,2,3}
    t.upper(0, eq: false).should eq 1
    t.upper(1, eq: false).should eq 2
    t.upper(2, eq: false).should eq 3
    t.upper(3, eq: false).should eq nil
    t.upper(4, eq: false).should eq nil
  end
  
  it "lower eq" do
    t = RBST{1,2,3}
    t.lower(0).should eq nil
    t.lower(1).should eq 1
    t.lower(2).should eq 2
    t.lower(3).should eq 3
    t.lower(4).should eq 3
  end
  
  it "lower" do
    t = RBST{1,2,3}
    t.lower(0, eq: false).should eq nil
    t.lower(1, eq: false).should eq nil
    t.lower(2, eq: false).should eq 1
    t.lower(3, eq: false).should eq 2
    t.lower(4, eq: false).should eq 3
  end
  
  it "min" do
    t = RBST{1,2,3}
    t.min.should eq 1
  end
  
  it "max" do
    t = RBST{1,2,3}
    t.max.should eq 3
  end
  
  it "at" do
    t = RBST{1,2,3,4,5,6,7,8,9}
    t.at(0).should eq 1
    t.at(1).should eq 2
    t.at(2).should eq 3
    t.at(3).should eq 4
    t.at(4).should eq 5
    t.at(5).should eq 6
    t.at(6).should eq 7
    t.at(7).should eq 8
    t.at(8).should eq 9
    t.at(9).should eq nil
  end

  it "at" do
    t = RBST{1,2,3,4,5,6,7,8,9}
    t[0].should eq 1
    t[1].should eq 2
    t[2].should eq 3
    t[3].should eq 4
    t[4].should eq 5
    t[5].should eq 6
    t[6].should eq 7
    t[7].should eq 8
    t[8].should eq 9
    t[9].should eq nil
  end

  it "[]" do
    t = [5,4,4,3,2].to_multiset
    t[0].should eq 2
    t[1].should eq 3
    t[2].should eq 4
    t[3].should eq 4
    t[4].should eq 5
  end

  it "upper_index" do
    t = [2,3,4,4,4,5,6].to_multiset
    t.upper_index(1).should eq nil
    t.upper_index(2).should eq 0
    t.upper_index(4).should eq 4
    t.upper_index(5).should eq 5
    t.upper_index(7).should eq 6
  end


  it "upper_index" do
    t = [2,3,4,4,4,5,6].to_multiset
    t.upper_index(1, eq: false).should eq nil
    t.upper_index(2, eq: false).should eq nil
    t.upper_index(4, eq: false).should eq 1
    t.upper_index(5, eq: false).should eq 4
    t.upper_index(7, eq: false).should eq 6
  end

  it "lower_index" do
    t = [2,3,4,4,4,5,6].to_multiset
    t.lower_index(1).should eq 0
    t.lower_index(2).should eq 0
    t.lower_index(4).should eq 2
    t.lower_index(5).should eq 5
    t.lower_index(7).should eq nil
  end

  it "lower_index" do
    t = [2,3,4,4,4,5,6].to_multiset
    t.lower_index(1, eq: false).should eq 0
    t.lower_index(2, eq: false).should eq 1
    t.lower_index(4, eq: false).should eq 5
    t.lower_index(5, eq: false).should eq 6
    t.lower_index(7, eq: false).should eq nil
  end

  it "median" do
    t = RBST{1,1,1,2,2,4}
    t.median.should eq 1.5
  end

  it "median" do
    t = RBST{1,1,2,3,4}
    t.median.should eq 2
  end

  it "median" do
    t = RBST{1,2}
    t.median.should eq 1.5
  end

  it "median" do
    t = RBST{1}
    t.median.should eq 1
  end

end
