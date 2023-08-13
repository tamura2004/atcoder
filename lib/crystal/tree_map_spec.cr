require "spec"
require "crystal/tree_map"

describe TreeMap do
  it "usage" do
    # 初期値
    tr = TreeMap(Int32, Int64).new
    tr[10_000_000] = 20_000_000_000_000_i64
    tr[20_000_000] = 40_000_000_000_000_i64
    tr[30_000_000] = 60_000_000_000_000_i64

    # 更新、削除
    tr[20_000_000] = 80_000_000_000_000_i64
    tr.delete(30_000_000)

    # 結果
    tr[10_000_000].should eq 20_000_000_000_000_i64
    tr[20_000_000].should eq 80_000_000_000_000_i64
    tr[30_000_000]?.should eq nil
  end

  it "usage" do
    tr = TreeMap(Int32, Int32).new
    tr[100] = 301
    tr[200] = 201
    tr[300] = 401
    tr[301] = 101

    tr.upper_key(200).should eq 200
    tr.upper_key(200, eq: false).should eq 300
    tr.upper_key(201).should eq 300
    tr.upper_key(300).should eq 300
    tr.upper_key(300, eq: false).should eq 301
    tr.upper_key(301).should eq 301
    tr.upper_key(301, eq: false).should be_nil
    tr.upper_key(302).should be_nil

    tr.lower_key(300).should eq 200
    tr.lower_key(300, eq: true).should eq 300
    tr.lower_key(100).should be_nil
    tr.lower_key(100, eq: true).should eq 100

    tr[200] = 1001
    tr[200].should eq 1001
    tr[300].should eq 401
    tr[500]?.should be_nil
  end
end

# 100 200 | 300 301
