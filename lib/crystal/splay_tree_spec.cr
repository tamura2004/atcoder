require "spec"
require "crystal/splay_tree"

describe SplayTree do
  it "zig" do
    up = Node(String).new("up")
    me = Node(String).new("me")
    hi = Node(String).new("hi")

    up.lo = me
    me.up = up
    me.hi = hi
    hi.up = me

    # up.inspect.should eq "(up (me . (hi . .)) .)"
    # me.inspect.should eq "(me . (hi . .))"
    # hi.inspect.should eq "(hi . .)"
    up.up.v.should eq "."
    up.lo.v.should eq "me"
    up.hi.v.should eq "."
    me.up.v.should eq "up"
    me.lo.v.should eq "."
    me.hi.v.should eq "hi"
    me.zig
    up.up.v.should eq "me"
    up.lo.v.should eq "hi"
    up.hi.v.should eq "."
    me.up.v.should eq "."
    me.lo.v.should eq "."
    me.hi.v.should eq "up"
    # me.inspect.should eq "(me . (up (hi . .) .))"
    # up.inspect.should eq "(up (hi . .) .)"
    # hi.inspect.should eq "(hi . .)"
  end
end
