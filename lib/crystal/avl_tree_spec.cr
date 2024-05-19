require "spec"
require "crystal/avl_tree"

describe AVLTree do
  it "usage" do
    tr = (1..100).to_a.to_avl
    tr.size.should eq 100
    tr.root.try(&.height).should eq 7 # log2(100)=6.6..なので平衡している
  end

  it "delete" do
    tr = [11, 29, 89].to_avl
    tr >> 29
    tr[1].should eq 89
    tr >> 89
    tr[0].should eq 11
  end

  it "lower" do
    tr = [1, 3, 5].to_avl

    # 以下
    [nil, 1, 1, 3, 3, 5, 5].each_with_index do |want, i|
      tr.lower(i).should eq want
    end

    # 未満
    [nil, nil, 1, 1, 3, 3, 5].each_with_index do |want, i|
      tr.lower(i, eq: false).should eq want
    end

    # 以下のインデックス
    [nil, 0, 0, 1, 1, 2, 2].each_with_index do |want, i|
      tr.lower_index(i).should eq want
    end

    # 未満のインデックス
    [nil, nil, 0, 0, 1, 1, 2].each_with_index do |want, i|
      tr.lower_index(i, eq: false).should eq want
    end

    # 以下の個数
    [0, 1, 1, 2, 2, 3, 3].each_with_index do |want, i|
      tr.lower_count(i).should eq want
    end

    # 未満の個数
    [0, 0, 1, 1, 2, 2, 3].each_with_index do |want, i|
      tr.lower_count(i, eq: false).should eq want
    end
  end

  it "upper" do
    tr = [1, 3, 5].to_avl

    # 以上
    [1, 1, 3, 3, 5, 5, nil].each_with_index do |want, i|
      tr.upper(i).should eq want
    end

    # 越える
    [1, 3, 3, 5, 5, nil, nil].each_with_index do |want, i|
      tr.upper(i, eq: false).should eq want
    end

    # 以上のインデックス
    [0, 0, 1, 1, 2, 2, nil].each_with_index do |want, i|
      tr.upper_index(i).should eq want
    end

    # 越えるのインデックス
    [0, 1, 1, 2, 2, nil, nil].each_with_index do |want, i|
      tr.upper_index(i, eq: false).should eq want
    end

    # 以上の個数
    [3, 3, 2, 2, 1, 1, 0].each_with_index do |want, i|
      tr.upper_count(i).should eq want
    end

    # 越えるの個数
    [3, 2, 2, 1, 1, 0, 0].each_with_index do |want, i|
      tr.upper_count(i, eq: false).should eq want
    end
  end

  # 小さいほうからk番目
  it "at" do
    tr = AVLTree{1, 3, 5}
    [1, 3, 5, nil].each_with_index do |want, k|
      tr[k].should eq want
    end
  end

  # 大きいほうからk番目
  it "at" do
    tr = AVLTree{1, 3, 5}
    [1, 5, 3, 1].each_with_index do |want, k|
      tr[-k].should eq want
    end
  end

  it "min max" do
    tr = AVLTree{1, 3, 5}
    tr.min.should eq 1
    tr.max.should eq 5
  end

  it "insert at" do
    tr = (0...10).to_a.to_avl
    tr[3] = 3
    tr[7] = 7
    tr.to_a.should eq [0, 1, 2, 3, 3, 4, 5, 7, 6, 7, 8, 9]
  end

  it "count" do
    tr = [-1000000000_i64, 10000_i64, 1000000000_i64].to_avl
    tr.count(..20000_i64).should eq 2
    tr.count(-10000_i64..20000_i64).should eq 1
    tr.count(-10000_i64..).should eq 2
  end
end
