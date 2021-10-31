require "spec"
require "crystal/string/kmp"

describe Kmp do
  it "usage" do
    s = "aabaabaaa"
    pp Kmp.new(s).solve
  end
end
