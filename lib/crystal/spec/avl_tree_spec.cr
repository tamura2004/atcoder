require "spec"
require "crystal//avl_tree"

describe AVLTree do
  it "usage" do
    tr = AVLTree(Int32).new
    3.times do |i|
      tr.insert i
    end
    # tr.inspect.should eq "(1 (0 . .) (2 . .))"
    tr.at(1).should eq 1
    tr.size.should eq 3
  end
  
  it "delete" do
    tr = AVLTree(Int32).new
    tr.insert 11
    tr.insert 29
    tr.insert 89

    tr.delete 29
    tr.at(1).should eq 89
    tr.delete 89
    tr.at(0).should eq 11
    # tr.inspect.should eq "(11 . .)"
  end
  
  it "lower" do
    tr = AVLTree(Int32).new
    tr.insert 1
    tr.insert 3
    tr.insert 5
    tr.insert 7

    tr.lower(0).should eq nil
    tr.lower(4).should eq 3
    tr.lower(5, eq: false).should eq 3
    tr.lower(5).should eq 5

    tr.lower_index(0).should eq nil
    tr.lower_index(1).should eq 0
    tr.lower_index(4).should eq 1
    tr.lower_index(5, eq: false).should eq 1
    tr.lower_index(5).should eq 2
    tr.lower_index(9).should eq 3

    tr.lower_count(0).should eq 0
    tr.lower_count(1).should eq 1
    tr.lower_count(4).should eq 2
    tr.lower_count(5, eq: false).should eq 2
    tr.lower_count(5).should eq 3
    tr.lower_count(9).should eq 4
  end
  
  it "upper" do
    tr = AVLTree(Int32).new
    tr.insert 1
    tr.insert 3
    tr.insert 5
    tr.insert 7

    tr.upper(4).should eq 5
    tr.upper(5, eq: false).should eq 7
    tr.upper(5).should eq 5

    tr.upper_index(0).should eq 0
    tr.upper_index(1).should eq 0
    tr.upper_index(2).should eq 1
    tr.upper_index(3).should eq 1
    tr.upper_index(4).should eq 2
    tr.upper_index(5).should eq 2
    tr.upper_index(6).should eq 3
    tr.upper_index(7).should eq 3
    tr.upper_index(7, eq: false).should eq nil
    tr.upper_index(8).should eq nil
    tr.upper_index(9).should eq nil

    tr.upper_count(0).should eq 4
    tr.upper_count(1).should eq 4
    tr.upper_count(2).should eq 3
    tr.upper_count(3).should eq 3
    tr.upper_count(4).should eq 2
    tr.upper_count(5).should eq 2
    tr.upper_count(6).should eq 1
    tr.upper_count(7).should eq 1
    tr.upper_count(7, eq: false).should eq 0
    tr.upper_count(8).should eq 0
    tr.upper_count(9).should eq 0
  end
  
  it "at" do
    tr = AVLTree(Int32).new
    tr.insert 1
    tr.insert 3
    tr.insert 5
    tr.insert 7

    tr.at(2).should eq 5
    tr.at(3).should eq 7
  end

  it "min max" do
    tr = [1,3,5,7].to_ordered_set
    tr.min.should eq 1
    tr.max.should eq 7
  end
end
