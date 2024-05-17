require "spec"
require "crystal/orderedset"

describe Orderedset do
  it "can initialize" do
    st = [3, 1, 4, 1, 5].to_ordered_set # => [1, 3, 4, 5]
  end

  it "lower eq" do
    st = [3, 1, 4, 1, 5].to_ordered_set # => [1, 3, 4, 5]

    param = [0, 1, 2, 3, 4, 5, 6]
    wants = [nil, 1, 1, 3, 4, 5, 5]

    param.zip(wants).each do |p, w|
      st.lower(p).should eq w
    end
  end

  it "lower" do
    st = [3, 1, 4, 1, 5].to_ordered_set # => [1, 3, 4, 5]

    param = [0, 1, 2, 3, 4, 5, 6]
    wants = [nil, nil, 1, 1, 3, 4, 5]

    param.zip(wants).each do |p, w|
      st.lower(p, eq: false).should eq w
    end
  end

  it "upper eq" do
    st = [3, 1, 4, 1, 5].to_ordered_set # => [1, 3, 4, 5]

    param = [0, 1, 2, 3, 4, 5, 6]
    wants = [1, 1, 3, 3, 4, 5, nil]

    param.zip(wants).each do |p, w|
      st.upper(p).should eq w
    end
  end

  it "upper" do
    st = [3, 1, 4, 1, 5].to_ordered_set # => [1, 3, 4, 5]
    
    param = [0, 1, 2, 3, 4, 5, 6]
    wants = [1, 3, 3, 4, 5, nil, nil]
    
    param.zip(wants).each do |p, w|
      st.upper(p, eq: false).should eq w
    end
  end
  
  it "can delete" do
    st = [3, 1, 4, 1, 5].to_ordered_set # => [1, 3, 4, 5]
    st.delete(4)
    st.lower(4).should eq 3
    st.upper(4).should eq 5
  end

  it "can initialized by tuple" do
    st = [{-10, -5}, {-3, 3}, {10, 20}].to_ordered_set
    st.lower({-2, 100}).should eq({-3, 3})
  end
end
