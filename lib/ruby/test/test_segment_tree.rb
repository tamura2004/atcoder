require "minitest/autorun"
require_relative "../segment_tree"

class TestSegmentTree < Minitest::Test
  def setup
    a = [1, 5, 2, 4, 3]
    e = 99
    f = ->x, y { x < y ? x : y }
    @range_min_query = SegmentTree.create(a, e, f)
  end

  def test_query
    assert_equal 2, @range_min_query.query(1, 3)
    assert_equal 5, @range_min_query.query(1, 2)
    assert_equal 1, @range_min_query.query(0, 2)
  end
end
