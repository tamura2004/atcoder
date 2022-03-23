require "spec"
require "crystal//avl_tree"

describe AVLTree do
  it "usage" do
    tr = AVLTree(Int32).new
    4.times do |i|
      tr.insert i
    end
    tr.delete(3)
    tr.delete(-1)
    tr.inspect.should eq "(1 (0 nil nil) (2 nil nil))"
  end

  it "delete" do
    tr = AVLTree(Int32).new
    tr.insert 10
    tr.delete 10
    tr.insert 1
    tr.inspect.should eq "(1 nil nil)"
  end
end
