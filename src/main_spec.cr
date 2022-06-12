require "spec"
require "crystal/ntt_convolution"

include Random::Secure

MOD = 998244353

describe "ceil_pow2" do
  it { ceil_pow2(10).should eq 4 }
  it { ceil_pow2(2**10).should eq 10 }
  it { ceil_pow2(2**10 - 1).should eq 10 }
end


describe "well_known_primitive_root" do
  it { well_known_primitive_root(2).should eq 1 }
  it { well_known_primitive_root(167772161).should eq 3 }
  it { well_known_primitive_root(469762049).should eq 3 }
  it { well_known_primitive_root(754974721).should eq 11 }
  it { well_known_primitive_root(998244353).should eq 3 }
  it { well_known_primitive_root(1000000007).should eq nil }
end

describe "primitive_root" do
  it { primitive_root(10**9+7).should eq 5 }
  it { primitive_root(754974721).should eq 11 }
end

describe "bsf" do
  it { bsf(0b10).should eq 1 }
  it { bsf(0b1100).should eq 2 }
  it { bsf(0b111000).should eq 3 }
  it { bsf(0b1010000).should eq 4 }
  it { bsf(0b10100000).should eq 5 }
end

describe "pow_mod" do
  it { pow_mod(100000, 100, 10**9+7).should eq 587199608 }
end

describe "butterfly_unit" do
  it {
    g = primitive_root(MOD)
    butterfly_unit(g,MOD).should eq ( {23,[911660635, 372528824, 929031873, 452798380, 922799308, 781712469, 476477967, 166035806, 258648936, 584193783, 63912897, 350007156, 666702199, 968855178, 629671588, 24514907, 996173970, 363395222, 565042129, 733596141, 267099868, 15311432, 0, 0, 0, 0, 0, 0, 0, 0], [86583718, 509520358, 337190230, 87557064, 609441965, 135236158, 304459705, 685443576, 381598368, 335559352, 129292727, 358024708, 814576206, 708402881, 283043518, 3707709, 121392023, 704923114, 950391366, 428961804, 382752275, 469870224, 0, 0, 0, 0, 0, 0, 0, 0]})
  }
end

describe "butterfly_init" do
  it {
    g = primitive_root(MOD)
    butterfly_init(g, MOD).should eq [911660635, 509520358, 369330050, 332049552, 983190778, 123842337, 238493703, 975955924, 603855026, 856644456, 131300601, 842657263, 730768835, 942482514, 806263778, 151565301, 510815449, 503497456, 743006876, 741047443, 56250497, 867605899, 0, 0, 0, 0, 0, 0, 0, 0]
  }
end

describe "butterfly" do
  it {
    a = [1,2,3,4,5,6,7,8].map &.to_i64
    butterfly(a, MOD)
    a.should eq [36, 998244349, 346334868, 651909477, 894301004, 796613085, 201631260, 103943341]
  }
end

describe "butterfly_inv" do
  it {
    a = [36, 998244349, 346334868, 651909477, 894301004, 796613085, 201631260, 103943341].map &.to_i64
    butterfly_inv(a, MOD)
    a.should eq [8, 16, 24, 32, 40, 48, 56, 64]
  }
end


describe "butterfly_inv_init" do
  it {
    g = primitive_root(MOD)
    butterfly_inv_init(g, MOD).should eq [86583718, 372528824, 373294451, 645684063, 112220581, 692852209, 155456985, 797128860, 90816748, 860285882, 927414960, 354738543, 109331171, 293255632, 535113200, 308540755, 121186627, 608385704, 438932459, 359477183, 824071951, 103369235, 0, 0, 0, 0, 0, 0, 0, 0]
  }
end

N = 100
describe "convolution" do
  it "should eq mini" do
      a = Array.new(N) { rand(0..MOD - 1).to_i64 }
      b = Array.new(N) { rand(0..MOD - 1).to_i64 }
      c = a.dup
      d = b.dup
      convolution(a,b,MOD).should eq convolution_mini(c,d,MOD)
  end
end
