require "spec"
require "crystal/baby_step_giant_step"

describe BabyStepGiantStep do
  it "usage" do
    x = 3_i64
    y = 193_i64
    mod = 10_i64**9 + 7

    r = BabyStepGiantStep.solve(x, y, mod)
    BabyStepGiantStep.modpow(x, r, mod).should eq y
  end
end
