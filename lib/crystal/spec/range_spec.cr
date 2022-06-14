require "spec"
require "crystal/range"

describe Range do
  it "usage" do
    (10..20).reverse_bsearch(&.< 10).should eq nil
    (10..20).reverse_bsearch(&.<= 10).should eq 10

    (10..20).reverse_bsearch(&.< 15).should eq 14
    (10..20).reverse_bsearch(&.<= 15).should eq 15

    (10..20).reverse_bsearch(&.< 20).should eq 19
    (10..20).reverse_bsearch(&.<= 20).should eq 20

    (10..20).reverse_bsearch(&.< 100).should eq 20
    (10..20).reverse_bsearch(&.<= 100).should eq 20
  end
end
