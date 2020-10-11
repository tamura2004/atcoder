require "spec"
require "../treap"

describe Node do
  it "usage" do
    bt = Node.new('$')
    "coolcrystal".chars.each do |c|
      bt << c
    end
    bt.to_s.should eq "$acclloorsty"
  end
end
