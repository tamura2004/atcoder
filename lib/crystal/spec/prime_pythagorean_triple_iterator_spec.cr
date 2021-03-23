require "spec"
require "../prime_pythagorean_triple_iterator"

describe PrimePythagoreanTripleIterator do
  it "usage" do
    i = PrimePythagoreanTripleIterator.new
    i.first(3).to_a.should eq [[3, 4, 5], [5, 12, 13], [8, 15, 17]]
  end
end
