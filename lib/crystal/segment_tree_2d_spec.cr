require "spec"
require "crystal/segment_tree_2d"

describe SegmentTree2D do
  it "usage" do
    values = [
      [1, 2, 3],
      [4, 5, 6],
      [7, 8, 9],
    ]
    st = SegmentTree2D(Int32).new(3, 3, unit: 0) do |i, j|
      i + j
    end

    3.times do |y|
      3.times do |x|
        st[y, x] = values[y][x]
      end
    end
    st.query(0, 3, 0, 3).should eq 45
    st.query(0, 2, 0, 3).should eq 21
    st.query(0, 1, 0, 3).should eq 6
    st.query(0, 1, 0, 2).should eq 3
    st.query(1, 3, 1, 3).should eq 28
    st[1..2,1..2].should eq 28
  end

  it "range max" do
    values = [
      [1, 2, 3],
      [4, 5, 6],
      [7, 8, 9],
    ]
    st = SegmentTree2D(Int32).new(3, 3, unit: Int32::MIN) do |i, j|
      Math.max i, j
    end

    3.times do |y|
      3.times do |x|
        st.update(y, x, values[y][x])
      end
    end
    st.query(0, 3, 0, 3).should eq 9
    st.query(0, 2, 0, 3).should eq 6
    st.query(0, 1, 0, 3).should eq 3
    st.query(0, 1, 0, 2).should eq 2
    st.query(1, 3, 1, 3).should eq 9
  end
end
