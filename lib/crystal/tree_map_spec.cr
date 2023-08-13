require "spec"
require "crystal/tree_map"

describe TreeMap do
  it "usage" do
    tr = TreeMap(Int32,Int32).new
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
    tr.upper_key(301, eq: false).should eq nil
    tr.upper_key(302).should eq nil

    tr.lower_key(300).should eq 200
    tr.lower_key(300, eq: true).should eq 300
    # tr.lower(250).should eq 201
  end
end
