require_relative "./main.rb"
include RSpec

describe "compress" do
  it "usage" do
    expect(compress([1, 1, 2, 2, 1, 1, 1])).to eq [[1, 2], [2, 2], [1, 3]]
  end
end
