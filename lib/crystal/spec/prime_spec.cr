require "spec"
require "../prime"

describe Prime do
  describe "prime?" do
    cases = [
      {0, false},
      {1, false},
      {2, true},
      {3, true},
      {4, false},
      {5, true},
      {6, false},
      {7, true},
      {8, false},
    ]
    cases.each do |i,want|
      Prime.prime?(i).should eq want
    end
  end

  describe "prime_division" do
    cases = [
      {0, {} of Int32 => Int32},
      {1, {} of Int32 => Int32},
      {7, {7 => 1}},
      {8, {2 => 3}},
      {12, {2 => 2, 3 => 1}},
    ]
    cases.each do |i, want|
      Prime.prime_division(i).should eq Factor.new(want)
    end

    cases.each do |i, want|
      Prime.division(i).should eq Factor.new(want)
    end
  end

  describe "prime_division of collection" do
    param = {7,8,12}
    want = [
      Factor.new({7 => 1}),
      Factor.new({2 => 3}),
      Factor.new({2 => 2, 3 => 1}),
    ]
    Prime.prime_division(*param).should eq want
    Prime.division(*param).should eq want
  end

  describe "prime_division_conv" do
    param = {7,8,12}
    want = Factor.new({2 => 5, 3 => 1, 7 => 1})
    Prime.prime_division_conv(*param).should eq want
    Prime.division_conv(*param).should eq want
  end

  describe "Iterable" do
    it "first" do
      Prime.rewind
      Prime.each.first(3).to_a.should eq [2, 3, 5]
    end

    it "select" do
      Prime.rewind
      Prime.each.select { |v| v < 2_000_000 }.sum
        .should eq 142913828922
    end
  end
end

describe Factor do
  it "number of divisors" do
    subject = Prime.division(240)
    subject.num_of_divisors.should eq 20
  end

  it "number of divisors" do
    subject = Factor.new({2 => 4, 3 => 1})
    subject.num_of_divisors.should eq 10
  end
end
