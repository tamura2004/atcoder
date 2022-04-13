require "spec"
require "crystal//splay_tree"

describe SplayTree do
  it "usage" do
    st = SplayTree(Int32,Int32).new
    # st.insert(1,2)
    # st.inspect.should eq "( 1:2 )"
    # st.insert(3,4)
    # st.inspect.should eq "(( 1:0 ) 3:2 )"
  end
end
