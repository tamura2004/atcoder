require "spec"
require "../combination"

describe "combination" do
  it "usage" do
    c = combination(60,60)
    c[6][3].should eq 20
    c[60][30].should eq 118264581564861424
  end
end

