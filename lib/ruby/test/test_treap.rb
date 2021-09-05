require "minitest/autorun"
require_relative "../treap"

class TestTreap < Minitest::Test
  def setup
  end

  def test_merge
    left = Treap.new
    left.root = Treap::Node.new(5, 10)
    left.root.left = Treap::Node.new(4, 4)
    left.root.right = Treap::Node.new(6, 7)

    right = Treap.new
    right.root = Treap::Node.new(8, 11)
    right.root.left = Treap::Node.new(7, 3)
    right.root.right = Treap::Node.new(9, 8)

    tree = left.merge(right)

    assert_equal 8, tree.root.val
    assert_equal 11, tree.root.pri
    assert_equal 5, tree.root.left.val
    assert_equal 10, tree.root.left.pri
    assert_equal 4, tree.root.left.left.val
    assert_equal 4, tree.root.left.left.pri
    assert_nil tree.root.left.left.right
    assert_nil tree.root.left.left.left
    assert_equal 6, tree.root.left.right.val
    assert_equal 7, tree.root.left.right.pri
    assert_nil tree.root.left.right.left
    assert_equal 7, tree.root.left.right.right.val
    assert_equal 3, tree.root.left.right.right.pri
    assert_nil tree.root.left.right.right.right
    assert_nil tree.root.left.right.right.left
    assert_equal 9, tree.root.right.val
    assert_equal 8, tree.root.right.pri
    assert_nil tree.root.right.right
    assert_nil tree.root.right.left

    fst, snd = tree.split(7)
    fst_tree = Treap.new(fst)
    snd_tree = Treap.new(snd)
    assert_equal Treap::Node, fst.class
    assert_equal Treap::Node, snd.class
    assert_equal 5, fst_tree.root.val
    assert_equal 4, fst_tree.root.left.val
    assert_equal 6, fst_tree.root.right.val
    assert_equal 8, snd_tree.root.val
    assert_equal 7, snd_tree.root.left.val
    assert_equal 9, snd_tree.root.right.val
  end

  def test_nil_merge
    tree = Treap.new
    node = Treap::Node.new(8, 11)
    tree.root = node

    nil_tree = Treap.new
    tree.merge(nil_tree)

    assert_equal Treap, tree.class
    assert_equal 8, tree.root.val

    other = nil_tree.merge(tree)
    assert_equal Treap, other.class
    assert_equal 8, other.root.val
  end

  def test_insert
    tree = Treap.new
    tree.insert 8, 11
    tree.insert 7, 3
    tree.insert 9, 8
    tree.insert 5, 10
    tree.insert 4, 4
    tree.insert 6, 7
    assert_equal 8, tree.root.val
    assert_equal 11, tree.root.pri
    assert_equal 5, tree.root.left.val
    assert_equal 10, tree.root.left.pri
    assert_equal 4, tree.root.left.left.val
    assert_equal 4, tree.root.left.left.pri
    assert_nil tree.root.left.left.right
    assert_nil tree.root.left.left.left
    assert_equal 6, tree.root.left.right.val
    assert_equal 7, tree.root.left.right.pri
    assert_nil tree.root.left.right.left
    assert_equal 7, tree.root.left.right.right.val
    assert_equal 3, tree.root.left.right.right.pri
    assert_nil tree.root.left.right.right.right
    assert_nil tree.root.left.right.right.left
    assert_equal 9, tree.root.right.val
    assert_equal 8, tree.root.right.pri
    assert_nil tree.root.right.right
    assert_nil tree.root.right.left

    assert_nil tree.upper(10)
    assert_equal 7, tree.lower(7)
    assert_equal 7, tree.upper(7)
    assert_nil tree.lower(0)
  end
end
