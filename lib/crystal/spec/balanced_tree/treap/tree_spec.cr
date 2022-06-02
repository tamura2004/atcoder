require "spec"
require "crystal/balanced_tree/treap/tree"
include BalancedTree::Treap

# def test_tree
#   n1 = Node(Int32).new(1)
#   n2 = Node(Int32).new(2)
#   n3 = Node(Int32).new(3)
#   n2.left = n1
#   n2.right = n3
#   Tree(Node(Int32)).new(n2)
# end

describe BalancedTree::Treap::Tree do
  # it "split" do
  #   t1 = test_tree
  #   t2 = t1.split(2)
  #   t3 = t2.split(3)
  #   t1.root.not_nil!.key.should eq 1
  #   t2.root.not_nil!.key.should eq 2
  #   t3.root.not_nil!.key.should eq 3
  # end

  # it "split alias" do
  #   t1 = test_tree
  #   t2 = t1 | 2
  #   t3 = t2 | 3
  #   t1.root.not_nil!.key.should eq 1
  #   t2.root.not_nil!.key.should eq 2
  #   t3.root.not_nil!.key.should eq 3
  # end

  # it "split_at" do
  #   t1 = test_tree
  #   t2 = t1.split_at(1)
  #   t3 = t2.split_at(1)
  #   t1.root.not_nil!.key.should eq 1
  #   t2.root.not_nil!.key.should eq 2
  #   t3.root.not_nil!.key.should eq 3
  # end

  # it "split_at alias" do
  #   t1 = test_tree
  #   t2 = t1 ^ 1
  #   t3 = t2 ^ 1
  #   t1.root.not_nil!.key.should eq 1
  #   t2.root.not_nil!.key.should eq 2
  #   t3.root.not_nil!.key.should eq 3
  # end

  # it "merge" do
  #   t1 = test_tree
  #   t2 = t1.split_at(1)
  #   t3 = t2.split_at(1)
  #   t1.merge(t2)
  #   t1.merge(t3)
  #   t1.size.should eq 3
  # end

  # it "merge alias" do
  #   t1 = test_tree
  #   t2 = t1.split_at(1)
  #   t3 = t2.split_at(1)
  #   t1 + t2 + t3
  #   t1.size.should eq 3
  # end

  # it "empty?" do
  #   node = Node(Int32).new(1)
  #   tree = Tree(Node(Int32)).new(node)
  #   tree.empty?.should eq false
  # end

  # it "inspect" do
  #   node = Node(Int32).new(1)
  #   tree = Tree(Node(Int32)).new(node)
  #   tree.inspect.should eq node.inspect
  # end

  # it "to_s" do
  #   node = Node(Int32).new(1)
  #   tree = Tree(Node(Int32)).new(node)
  #   tree.to_s.should eq node.to_s
  # end
end
